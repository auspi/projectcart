FROM ubuntu:14.04

MAINTAINER Dockerfiles

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && apt-get install -y \
	git \
	python \
	python-dev \
	python-setuptools \
	nginx \
	supervisor \
	sqlite3 \
  && rm -rf /var/lib/apt/lists/*

RUN easy_install pip

# install uwsgi now because it takes a little while
RUN pip install uwsgi

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/

# COPY requirements.txt and RUN pip install BEFORE adding the rest of your code, this will cause Docker's caching mechanism
# to prevent re-installinig (all your) dependencies when you made a change a line or two in your app.

COPY requirements.txt /home/docker/code/
RUN pip install -r /home/docker/code/requirements.txt

# add (the rest of) our code
COPY . /home/docker/code/

VOLUME /var/log/supervisor/

EXPOSE 80
CMD ["supervisord", "-n"]