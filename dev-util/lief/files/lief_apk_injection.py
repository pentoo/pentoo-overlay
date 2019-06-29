#!/usr/bin/env python3

import lief
import zipfile
import shutil
import subprocess
import tempfile
import os
import pathlib
import requests
import re
from xtract import xtract


def inject(libdir, arch, selected_library):
    # Get latests frida-gadgets
    latest = requests.get(url = "https://github.com/frida/frida/releases/latest")

    # Get stable frida-gadgets
    #latest = requests.get(url = "https://github.com/frida/frida/releases/tag/12.5.4")

    response = latest.content.decode('utf-8')
    latestArch = re.findall(r'\/frida\/frida\/releases\/download\/.*\/frida-gadget.*\-android\-.*xz',response)
    url_gadget = ""
    for i in latestArch:
         if  gadget_architecture[arch] in i:
            url_gadget = i

    print("[+] Downloading and extracting frida gadget for: " + arch )
    url = 'https://github.com'+str(url_gadget)
    r = requests.get(url)
    filename = "frida-gadget"+str(arch)+".so.xz"
    with open(libdir / arch / filename , 'wb') as f:  
        f.write(r.content)
    xtract(str(libdir / arch / filename))
    gadget_name = "libgdgt.so"
    os.rename(libdir / arch / filename[:-3], libdir / arch / gadget_name)
    os.remove (libdir / arch / filename)
    print(f"[+] Injecting {gadget_name} into {arch}/{selected_library} \n")
    libcheck_path = libdir / arch / selected_library
    libcheck = lief.parse(libcheck_path.as_posix())
    libcheck.add_library(gadget_name)
    libcheck.write(libcheck_path.as_posix())

# Get file
apk = input("[+] Enter the path of your APK: ")

try:
    f = open(apk,'r+')
except:
    print("[+] I did not find the file at, "+str(apk))
    exit()

f = open(apk,'r+')
#stuff you do with the file goes here
f.close()

# Unzip
workingdir = tempfile.mkdtemp(suffix='_lief_frida')

print(f"[+] Unzip the {apk} in {workingdir}")
zip_ref = zipfile.ZipFile(apk, 'r')
zip_ref.extractall(workingdir)
zip_ref.close()

libdir = pathlib.Path(workingdir) / "lib"



gadget_architecture = {
     "arm64" : "android-arm64.so",
     "arm64-v8a" : "android-arm64.so",
     "armeabi" : "android-arm.so",
     "armeabi-v7a" : "android-arm.so",
     "x86" : "android-x86.so",
     "x86_64" : "android-x86_64.so"
}

print("[+] Select the architecture of your system: ")
print("If you don't know run: adb shell getprop ro.product.cpu.abi\n")

architectures = os.listdir(libdir)

counter_lib = 0
final_architectures = []
for i in architectures:
    if i in gadget_architecture:
        counter_lib+=1
        final_architectures.append(i)
        print(f"{counter_lib}) {i}")

print(f"{(counter_lib+1)}) I don't know. Inject frida-gadget for all architectures (slower)\n")

selected_arch = input("> ")

print("\n[+] In with library do you want to inject?: \n ")

if int(selected_arch) == (counter_lib+1):
    libraries = os.listdir(libdir/final_architectures[0])
else:
    libraries = os.listdir(libdir/final_architectures[int(selected_arch)-1])

counter = 0
for lib in libraries:
    counter += 1
    print(str(counter) + ") "+lib)
print("\n[+] Enter the number of the desired library: ")
library = input("> ")
selected_library = libraries[int(library)-1]


if int(selected_arch) == (counter_lib+1):
    for arch in final_architectures:
        inject(libdir, arch, libraries[int(library)-1])
else:
    inject(libdir,final_architectures[int(selected_arch)-1],libraries[int(library)-1])


print ("[*] Removing old signature ")

# Remove old signature
shutil.rmtree(os.path.join(workingdir, "META-INF"))

# Zip
print("[+] APK Building...")
apk_name = "my_app.apk"
shutil.make_archive("new", 'zip', workingdir)
shutil.move("new.zip", apk_name)

print(f"[+] SUCCESS!! Your new apk is : {apk_name}. Now you should sign it.\n")
