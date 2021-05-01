#!/usr/bin/sh

#* React templates
# react:yarn create react-app app
# react-redux:yarn create react-app --template redux
# react-ts-yarn:create react-app app --template typescript
# react-ts-redux:yarn create react-app --template redux-typescript

#* React native templates
# blank:expo init app --yarn -t blank
# blank-ts:expo init app --yarn -t expo-template-blank-typescript

#* Next js
# next:yarn create next-app app
# next-ts:yarn create next-app app; cd app; touch tsconfig.json; yarn add -d typescript @types/react @types/node

#* Flutter
# app:flutter create app; cd app;
# web:flutter create app --web

Help(){
 echo "Automate Projekt creation"
   echo
   echo "Syntax:  project-path -flags:[-react | -react-ts \n| -react-redux | -react-ts-redux | -rn | -rn-ts \n| -next | -next-ts  | -flutter ]"
   echo "options:"
   echo
   echo "-react					Plain react template"
   echo "-react-ts				React + TS"
   echo "-react-redux				React + Redux"
   echo "-react-ts-redux				React + TS + Redux"
   echo
   echo "-rn					React native + Expo"
   echo "-rn-ts					React native + Expo + TS"
   echo
   echo "-next					Next js"
   echo "-next-ts				Next js + TS"	
   echo
   echo "-flutter				Flutter"
}

github_no_cd(){
	gh repo create $1 --public -y
	git remote set-url origin git@github.com:joey364/$1.git
	git push -u origin main
}

github() {
	cd $1
	github_no_cd $1
}

param="$2"
while [ -n "$1" ]; do # while loop starts

	case "$1" in

	-react)
		echo "React"
		yarn create react-app "$param"
		github $param
		;; 

	-react-ts)
		echo "React Typescript"
		yarn create react-app $param --template typescript
		github $param
		;;

	-react-redux)
		echo "React Redux"
		yarn create react-app --template redux
		github $param
		;;

	-react-ts-redux)
		echo "React Redux TS template"
		yarn create react-app --template redux-typescript
		github $param
		;;

	-rn)
		echo "Expo blank template "
		expo init app --yarn -t blank
		github $param
		;;

	-rn-ts)
		echo "Expo blank typescript template"
		expo init app --yarn -t expo-template-blank-typescript
		github $param
		;;

	
	-next)
		echo "Next-js"
		yarn create next-app $param
		github $param
		;;

	-next-ts)
		echo "Next-js Typescript"
		yarn create next-app $param
		cd $param
		touch tsconfig.json
		yarn add -d typescript @types/react @types/node
		git add .
		git ci -m 'Setup: Added TS'
		github_no_cd $param
		;;

	-flutter)
		echo "Flutter"
		flutter create $param 
		github $param
		;;
	-h)
		Help
		exit
		;;

	*) echo "Option $1 not recognized" ;; # In case you typed a different option

	esac

	shift

done
