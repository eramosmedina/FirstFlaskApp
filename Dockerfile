FROM ubuntu:20.04

RUN apt update &&  apt install python3 python3-pip -y && pip3 install Flask

WORKDIR /apps/first_flask_app

COPY . /apps/first_flask_app

RUN pip3 --no-cache-dir install -r requirements.txt

CMD ["python3", "src/firstapp.py"]
