
#!/usr/bin/env sh 
set -e

usage="
Usage: new-node-cli --name name --help
	
-n | --name <name> 	Specify the name of the workflow
-h | --help			This help
"

# Absolute path:
# 
# Usage: abs=`get_abs_path ./deploy/static`
#		 echo $abs
# 
function get_abs_path {
   dir=$(cd `dirname $1` >/dev/null; pwd )
   echo $dir
}
#

# Get basename:
function get_base_name {
	n=$1
	n=$(basename "$n")
	echo "${n%.*}"
}


#if [ $? -eq 0 ]
#then
#    echo "it worked"
#else
#    echo "it failed"
#fi

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`

#
# Temp directory:
#
# dstdir=`mktemp -d -t bashtmp`
#
# or current:
#
dstdir=`pwd`

function directory_does_exist {
	if [ ! -d "$1" ]; then
		echo 'true'
	else
		echo 'false'
	fi
}

bold=$(tput bold)
reset=$(tput sgr0)
function print_important_message {
	printf "${bold}$1${reset}. "
}

function ask_for_key {
	printf "Press [enter] to continue"
	read -s # suppress user input
	echo 
}


# dryrun
dry_run=false
run() {
  echo "$1"
  if [[ $dry_run == false ]] ; then
    eval "$1"
  fi
}

name="new-node-cli"

while (($# > 0)) ; do
  option="$1"
  shift

  case "$option" in
    -h|--help)
      echo "$usage"
      exit
      ;;
    -n|--name)    name="$1"           ; shift ;;
    -d|--dry-run) dry_run=true       ;;
    *)
      echo "Unrecognized option $option" >&2
      exit 1
  esac
done

tlib="$srcdir/../lib/node_modules/cli-scaffold/template"
run "mkdir -p $dstdir/$name"
run "mkdir -p $dstdir/$name/docs"
run "< $tlib/package.json sed 's/__name__/$name/' > $dstdir/$name/package.json"
run "< $tlib/index.ls sed 's/__name__/$name/' > $dstdir/$name/index.ls"
run "< $tlib/usage.md sed 's/__name__/$name/' > $dstdir/$name/docs/usage.md"
run "cp $tlib/makefile $dstdir/$name"
run "cp $tlib/verbfile.js $dstdir/$name"
run "cp $tlib/readme.md $dstdir/$name/docs"



