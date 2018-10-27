FROM python:2


WORKDIR /root

ADD app /root/

RUN pip install -r requirements.txt

CMD bash wait-service.sh database 5432 && python models.py && python app.py
