#!/usr/bin/env bash

TARGET="${1:-go.sum}"
MODULES=()
WHITELIST=(
	"github.com"
	"bitbucket.org"
)

function in_whitelist() {
	local module="${1}"
	local state=0

	for w in ${WHITELIST[@]}; do
		[[ "${module}" == ${w}/* ]] && state=1
	done

	if [ ${state} -eq 0 ]; then
		return 1
	fi
}

function parse_gosum() {
	local gosum_file="${1}"
	local _prefix raw

	IFS=$'\n'
	for raw in $(cat "${gosum_file}" \
		| awk '{pn[FNR]=$1; pv[$1]=$2}
			END {
				for ( n in pn ) {
					if ( pn[n] != f ) {
						printf("%s %s\n", pn[n], pv[pn[n]])
						f=pn[n]
					}
				}
			}' \
		| sed -E "s/[[:space:]](v?([0-9]{1,}\.)?+[0-9]{1,}((\-r|_rc|_beta|_alpha)[0-9]{1,}?)?)[-+\/]/ \1 \2/")
	do
		module="$(echo ${raw} | cut -d' ' -f1)"
		version="$(echo ${raw} | cut -d' ' -f2)"
		revision="$(echo ${raw} | cut -d' ' -f3 | sed -E "s/^([a-z0-9.]{1,}-)([a-z0-9]{1,7}).*/\2/")"

		if ! in_whitelist "${module}"; then
			_prefix="(checkme) "
		else
			_prefix=""
		fi

		if ! [[ -z "${module}" ]]; then
			[[ "${version}" == *0.0.0 ]] \
				&& MODULES+=( "${_prefix}${module} ${revision}" ) \
				|| MODULES+=( "${_prefix}${module} ${version}" )
		fi
	done
}

function parse_gopkglock() {
	local pkglock_file="${1}"
	local _prefix raw

	IFS=$':'
	for raw in $(cat "${pkglock_file}" \
		| tr -d "[:blank:]\"" \
		| awk -F'=' '$1~/^name$/{printf(":%s ",$2)};$1~/^revision$|^version$/{printf("%s ",$2)}')
	do
		module="$(echo ${raw} | cut -d' ' -f1)"
		version="$(echo ${raw} | cut -d' ' -f3)"
		revision="$(echo ${raw} | cut -d' ' -f2 | cut -c1-7)"

		if ! in_whitelist "${module}"; then
			_prefix="(checkme) "
		else
			_prefix=""
		fi

		if ! [[ -z "${module}" ]]; then
			[[ -z "${version}" ]] \
				&& MODULES+=( "${_prefix}${module} ${revision}" ) \
				|| MODULES+=( "${_prefix}${module} ${version}" )
		fi
	done
}

function parse_gopkgtoml() {
	local pkgtoml_file="${1}"
	local _prefix raw

	IFS=$':'
	for raw in $(cat "${pkgtoml_file}" \
		| tr -d "[:blank:]\"" \
		| awk -F'=' '$1~/^name$/{printf(":%s ",$2)};$1~/^revision$|^version$/{printf("%s ",$2)}')
	do
		module="$(echo ${raw} | cut -d' ' -f1)"
		version="$(echo ${raw} | cut -d' ' -f2)"
		revision="$(echo ${raw} | cut -d' ' -f3)"

		if ! in_whitelist "${module}"; then
			_prefix="(checkme) "
		else
			_prefix=""
		fi

		if ! [[ -z "${module}" ]]; then
			[[ -z "${version}" ]] \
				&& MODULES+=( "${_prefix}${module} ${revision}" ) \
				|| MODULES+=( "${_prefix}${module} ${version}" )
		fi
	done
}

function parse_gomod() {
	local gomod_file="${1}"
	local _prefix raw

	IFS=$'\n'
	for raw in $(cat "${gomod_file}" \
		| awk -v'm=0' '
			m==0&&$1" "$2" "$3~/^require \"?(.*) (.*)\"?/&&$1" "$2!~/^require \($/ { m=1 }
			m==0&&$1" "$2~/^require \($/ { strl=FNR; m=2 }
			m==2&&$1~/^\)$/ { endl=FNR }
			m==1&&$1~/^require$/&&$2!="" { pn[FNR]=$2; pv[$2]=$3 }
			m==2 { pn[FNR]=$1; pv[$1]=$2 }
			END {
				switch (m) {
					case 1:
						for (n in pn)
							printf("%s %s\n", pn[n], pv[pn[n]])
						break
					case 2:
						for (n in pn) {
							if (n > strl) {
								printf("%s %s\n", pn[n], pv[pn[n]])
								if (n < endl) break
							}
						}
						break
				}
			}' \
		| sed -E "s/^[[:blank:]]\"?//;s/[[:space:]](v?([0-9]{1,}\.)?+[0-9]{1,}((\-r|_rc|_beta|_alpha)[0-9]{1,}?)?)[-+\/]/ \1 \2/")
	do
		module="$(echo ${raw} | cut -d' ' -f1)"
		version="$(echo ${raw} | cut -d' ' -f2)"
		revision="$(echo ${raw} | cut -d' ' -f3 | sed -E "s/^([a-z0-9.]{1,}-)([a-z0-9]{1,7}).*/\2/")"

		if ! in_whitelist "${module}"; then
			_prefix="(checkme) "
		else
			_prefix=""
		fi

		if ! [[ -z "${module}" ]]; then
			[[ "${version}" == *0.0.0 ]] \
				&& MODULES+=( "${_prefix}${module} ${revision}" ) \
				|| MODULES+=( "${_prefix}${module} ${version}" )
		fi
	done
}

#function parse_golist() {
#	:
#}
#
#function merge() {
#	#sort -k1 -k2 -V -r
#	:
#}

if ! [ -f "${TARGET}" ]; then
	echo "${TARGET} — is not found!"
	exit 1
fi

case "$(basename "${TARGET}")" in
	*.sum) parse_gosum "${TARGET}";;
	*.lock) parse_gopkglock "${TARGET}";;
	*.toml) parse_gopkgtoml "${TARGET}";;
#	*.list) parse_golist "${TARGET}";;
	*.mod) parse_gomod "${TARGET}";;
esac

echo -e "EGO_VENDOR=("
for mod in ${MODULES[@]}; do
	echo -e "\t\"${mod}\""
done
echo -e ")"
