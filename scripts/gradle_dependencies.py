#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
FIXME: migrate to
    https://gitlab.com/ysb33rOrg/gradle/ivypot-gradle-plugin
      or
    https://github.com/mdietrichstein/gradle-offline-dependencies-plugin

This script extracts gradle cache files into a separate directory for futher
offline installation

Add the following in build.gradle:
 repositories {
     if ('allow' == System.properties['build.network_access']) {
         mavenCentral()
     } else {
         maven { url 'dependencies' }
     }
 }
"""
__author__ = "https://stackoverflow.com/questions/28436473/build-gradle-repository-for-offline-development"

import re
import sys
import os
import subprocess
import glob
import shutil

# Gradle 9.x supports Java 25. The old Gradle 8.x limit of 24 no longer applies.
GRADLE_MAX_JAVA = 25


def _current_java_version():
    try:
        out = subprocess.check_output(
            ["java", "-version"], stderr=subprocess.STDOUT, text=True
        )
        m = re.search(r'version "(\d+)', out)
        if m:
            return int(m.group(1))
    except (subprocess.CalledProcessError, FileNotFoundError, ValueError):
        pass
    return None


def _find_compatible_java_home():
    """Return a JAVA_HOME path for a JVM <= GRADLE_MAX_JAVA, or None."""
    jvm_base = "/usr/lib/jvm"
    if not os.path.isdir(jvm_base):
        return None
    candidates = []
    for name in os.listdir(jvm_base):
        m = re.search(r"(\d+)", name)
        if m:
            ver = int(m.group(1))
            if ver <= GRADLE_MAX_JAVA:
                candidates.append((ver, os.path.join(jvm_base, name)))
    if not candidates:
        return None
    # prefer the highest compatible version
    candidates.sort(reverse=True)
    return candidates[0][1]


def _gradle_env():
    env = dict(os.environ)
    current = _current_java_version()
    if current is not None and current > GRADLE_MAX_JAVA:
        java_home = _find_compatible_java_home()
        if java_home:
            print(
                f"Java {current} is not supported by Gradle (max {GRADLE_MAX_JAVA}), "
                f"using {java_home}"
            )
            env["JAVA_HOME"] = java_home
        else:
            print(
                f"Warning: Java {current} exceeds Gradle max ({GRADLE_MAX_JAVA}) "
                f"and no compatible JVM was found under {'/usr/lib/jvm'}"
            )
    return env


def main(argv):
    build_param = "build"
#    build_param = "buildGhidra"
    if len(sys.argv) > 1:
        build_param = sys.argv[1]

    project_dir = os.path.dirname(os.path.realpath(__file__))
    repo_dir = os.path.join(project_dir, "dependencies")
    temp_home = os.path.join(project_dir, ".gradle_home")
    if not os.path.isdir(temp_home):
        os.makedirs(temp_home)
    subprocess.call(
        ["gradle", "-g", temp_home, "-Dbuild.network_access=allow", build_param],
        env=_gradle_env(),
    )
    cache_files = os.path.join(temp_home, "caches/modules-*/files-*")
    for cache_dir in glob.glob(cache_files):
        for cache_group_id in os.listdir(cache_dir):
            cache_group_dir = os.path.join(cache_dir, cache_group_id)
            repo_group_dir = os.path.join(repo_dir, cache_group_id.replace('.', '/'))
            for cache_artifact_id in os.listdir(cache_group_dir):
                cache_artifact_dir = os.path.join(cache_group_dir, cache_artifact_id)
                repo_artifact_dir = os.path.join(repo_group_dir, cache_artifact_id)
                for cache_version_id in os.listdir(cache_artifact_dir):
                    cache_version_dir = os.path.join(cache_artifact_dir, cache_version_id)
                    repo_version_dir = os.path.join(repo_artifact_dir, cache_version_id)
                    if not os.path.isdir(repo_version_dir):
                        os.makedirs(repo_version_dir)
                    cache_items = os.path.join(cache_version_dir, "*/*")
                    for cache_item in glob.glob(cache_items):
                        cache_item_name = os.path.basename(cache_item)
                        repo_item_path = os.path.join(repo_version_dir, cache_item_name)
                        print("%s:%s:%s (%s)" % (cache_group_id, cache_artifact_id, cache_version_id, cache_item_name))
                        shutil.copyfile(cache_item, repo_item_path)
    _generate_maven_metadata(repo_dir)
    shutil.rmtree(temp_home)
    return 0


def _generate_maven_metadata(repo_dir):
    """Generate maven-metadata.xml for each artifact dir so version ranges resolve offline."""
    from datetime import datetime
    timestamp = datetime.utcnow().strftime("%Y%m%d%H%M%S")

    for root, dirs, files in os.walk(repo_dir):
        # Detect artifact-level dirs: contain only version subdirs (no .jar/.pom directly)
        subdirs = [d for d in dirs]
        version_dirs = [d for d in subdirs if os.path.isdir(os.path.join(root, d))
                        and any(f.endswith(('.jar', '.pom', '.aar'))
                                for f in os.listdir(os.path.join(root, d)))]
        if not version_dirs:
            continue

        # Derive groupId and artifactId from path relative to repo_dir
        rel = os.path.relpath(root, repo_dir)
        parts = rel.replace(os.sep, '/').split('/')
        if len(parts) < 2:
            continue
        artifact_id = parts[-1]
        group_id = '.'.join(parts[:-1])

        def _ver_key(v):
            parts = re.split(r'[.\-]', v)
            return [int(p) if p.isdigit() else p for p in parts]

        versions = sorted(version_dirs, key=_ver_key)
        release = versions[-1]

        metadata_path = os.path.join(root, 'maven-metadata.xml')
        version_tags = '\n'.join(f'      <version>{v}</version>' for v in versions)
        content = f"""<?xml version="1.0" encoding="UTF-8"?>
<metadata>
  <groupId>{group_id}</groupId>
  <artifactId>{artifact_id}</artifactId>
  <versioning>
    <release>{release}</release>
    <versions>
{version_tags}
    </versions>
    <lastUpdated>{timestamp}</lastUpdated>
  </versioning>
</metadata>
"""
        with open(metadata_path, 'w') as f:
            f.write(content)
        print(f"maven-metadata.xml: {group_id}:{artifact_id} {versions}")

if __name__ == "__main__":
    sys.exit(main(sys.argv))
