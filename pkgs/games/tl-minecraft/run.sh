#!@shell@
launchDir="${XDG_DATA_HOME:-$HOME/.local/share}/tl"
configDir="${XDG_CONFIG_HOME:-$HOME/.config}/tl"

if [ ! -d "$launchDir" ]
then
  mkdir -p "$launchDir"
fi

if [ ! -e "$launchDir/Bootstrap.jar" ]
then
  cp @out@/share/tl/Bootstrap.jar "$launchDir/Bootstrap.jar"
  chmod u+w "$launchDir/Bootstrap.jar"
fi

PATH="$PATH:@xrandr@/bin" \
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib:@libs@" \
@jdk@/bin/java \
  -Dtlauncher.bootstrap.targetJar="$launchDir/bin/legacy.jar" \
  -Dtlauncher.bootstrap.targetLibFolder="$launchDir/lib" \
  -jar "$launchDir/Bootstrap.jar" \
  --settings "$configDir/legacy.properties"
