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
# add "gcc python3-dev musl-dev" to add mraiadb-dev, then remove deps
RUN apk add --no-cache gcc python3-dev musl-dev mariadb-dev 

RUN pip install mysqlclient
RUN pip install --upgrade pip && pip install --upgrade setuptools
COPY ./requirements.txt .
RUN pip install -r requirements.txt

RUN apk del gcc python3-dev musl-dev

COPY ./app/scripts/entrypoint.sh /app/scripts

ENTRYPOINT [ "sh", "/app/scripts/entrypoint.sh" ]
