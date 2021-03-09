# $(call assert,condition,message)
define assert
   $(if $1,,$(error Assertion failed: $2))
endef
# $(call assert-file-exists,wildcard-pattern, message)
define assert-file-exists
   $(call assert,$(wildcard $1),$1 does not exist. $2)
endef

regen: gen open	

validate:
	$(call assert-file-exists,project.local.yaml,🔥 Copy project.local.example.yaml file and modify your own fields)

clean:
	[ -d WineUp.xcodeproj ] && rm -r WineUp.xcodeproj
	[ -d WineUp.xcworkspace ] && rm -r WineUp.xcworkspace
	[ -f WineUp/WineUp.entitlements ] && rm WineUp/WineUp.entitlements 
	[ -f WineUp/Info.plist ] && rm WineUp/Info.plist

gen: validate
	xcodegen generate
	pod install --repo-update

open:
	open WineUp.xcworkspace

help:
	@echo "Use 'make gen' to generate Xcode workspace"
	@echo "Use 'make open' to open Xcode workspace"
	@echo "Use 'make clean' to remove Xcode workspace"
	@echo "Use 'make regen' to regenerate Xcode workspace and open it"
