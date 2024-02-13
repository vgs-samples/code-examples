.PHONY: test-larky

./tmp/starlarky:
	git clone git@github.com:verygoodsecurity/starlarky.git ./tmp/starlarky

test-larky: ./tmp/starlarky
	rm -f tmp/starlarky/larky/src/test/resources/quick_tests/**.star
	cp $$(find ./integrations/larky/ | grep .star) ./tmp/starlarky/larky/src/test/resources/quick_tests/
	cd ./tmp/starlarky; mvnw -Dtest='LarkyQuickTests*' test -pl larky
