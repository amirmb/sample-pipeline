FROM python:alpine
COPY . /app
WORKDIR /app
RUN apk add --update --no-cache make bash jq
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python ./main.py