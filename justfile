compile:
	rm -rf playground.pdx
	pdc source playground.pdx

simulate: compile
	killall -9 PlaydateSimulator -q || true
	PlaydateSimulator playground.pdx

alias run := simulate

release:
	rm -rf playground-release.pdx
	pdc -s source playground-release.pdx
	zip -r playground-release.pdx.zip playground-release.pdx

push:
	git push origin --all
	git push origin --tags
	git push gh --all
	git push gh --tags
