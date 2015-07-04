build:
	cd php7 && docker build -t nousefreak/php7 .
	cd php7-deb && docker build -t nousefreak/php7:deb .
	cd php7-symfony && docker build -t nousefreak/php7:symfony .
