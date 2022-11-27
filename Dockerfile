FROM python:3.10

RUN pip install -r requirements.txt
COPY . .

EXPOSE 5000
