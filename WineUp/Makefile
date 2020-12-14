regen: gen open	

clean:
	[ -d WineUp.xcodeproj ] && rm -r WineUp.xcodeproj
	[ -d WineUp.xcworkspace ] && rm -r WineUp.xcworkspace

gen:
	xcodegen generate
	pod install

open:
	open WineUp.xcworkspace

help:
	@echo "Use 'make gen' to generate Xcode workspace"
	@echo "Use 'make open' to open Xcode workspace"
	@echo "Use 'make clean' to remove Xcode workspace"
	@echo "Use 'make regen' to regenerate Xcode workspace and open it"
