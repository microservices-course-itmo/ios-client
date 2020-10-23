regen: gen open	

clean:
	[ -d WineUp.xcodeproj ] && rm -r WineUp.xcodeproj

gen:
	xcodegen generate

open:
	open WineUp.xcodeproj

help:
	@echo "Use 'make gen' to generate Xcode project"
	@echo "Use 'make open' to open Xcode project"
	@echo "Use 'make clean' to remove Xcode project"
	@echo "Use 'make regen' to regenerate Xcode project and open it"
