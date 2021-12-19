FROM python:3.8-alpine

WORKDIR /app
COPY ./app /app

# Python can now be prevented from writing .pyc or .pyo files,
# for cache (first time build and then use this compiled file)
ENV PYTHONDONTWRITEBYTECODE 1
# ensures that the python output is sent straight to terminal (e.g. your container log),
# without being first buffered and that you can see the output of your application (e.g. django logs) in real time
ENV PYTHONUNBUFFERED 1 

RUN echo 'nameserver 185.51.200.2'>>/etc/resolv.conf
RUN apk update
RUN apk add --virtual build-deps gcc python3-dev musl-dev mariadb-dev 
RUN apk add jpeg-dev zlib-dev libjpeg

RUN pip install --upgrade pip && pip install --upgrade setuptools
COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ls
CMD [ "python manage.py runserver 0.0.0.0:8000" ]
# ENTRYPOINT [ "/entrypoint.sh" ]
