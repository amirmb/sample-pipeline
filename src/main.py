import json
import pymysql
from sqlalchemy import MetaData, Column, Integer, String, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


RECEIVED_FILE_PATH = './files/drop-1.json'
COMPLETED_FILE_PATH = './files/completed/'
SKIPPED_FILE_PATH = './files/skipped/'

CONFIG = {
        'db_user': 'admin',
        'db_pwd': 'password',
        'db_host': 'db',
        'db_port': '3306',
        'db_name': 'store'
    }

DB_USER = CONFIG.get('db_user')
DB_PWD = CONFIG.get('db_pwd')
DB_HOST = CONFIG.get('db_host')
DB_NAME = CONFIG.get('db_name')
DB_PORT = CONFIG.get('db_port')

CONN_STR = f'mysql+pymysql://{DB_USER}:{DB_PWD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'

BASE = declarative_base(metadata=MetaData(schema='example'))

class Products(BASE):
    __tablename__ = 'products'
    sku = Column(Integer, primary_key=True)
    l3 = Column(String(20))
    qty = Column(Integer)
    category = Column(String(255))
    price = Column(Integer)
    description = Column(String(255))
    location = Column(String(255))

class TransmissionSummary(BASE):
    __tablename__ = 'transmissionsummary'
    qtysum = Column(Integer)
    recordcount = Column(Integer)
    Id = Column(String(255))
    PRIMARY = Column(Integer, primary_key=True)


def main():
    if validate():
        import_file()
        print(summary())
        complete_file()
    else:
        skip_file()

def complete_file():
    print(f"move the processed file to completed directory: ${COMPLETED_FILE_PATH}")

def skip_file():
    print(f"move the ignored file to skipped directory: ${SKIPPED_FILE_PATH}")

def read_json(element):
    print(f"read json file and return {element}")
    with open(RECEIVED_FILE_PATH) as file:
        json_object = json.load(file)
    return json_object[element]

def validate():
    print("Check if transmission summary id already exist and recordcount/qtysum has increased")
    return True

def import_file():
    print("insert data from json file to Database")

    products = read_json('products')
    transmissionsummary = read_json('transmissionsummary')


    engine = create_engine(CONN_STR)
    BASE.metadata.create_all(engine)

    session_maker = sessionmaker(bind=engine)
    session = session_maker()

    for product in products:
        p_record = Products(**product)
        session.add(p_record)

    for transmission_summary in transmissionsummary:
        ts_record = TransmissionSummary(**transmission_summary)
        session.add(ts_record)

    session.commit()


def summary():
    print("Displaying the summary")
    
    engine = create_engine(CONN_STR)
    query = "SELECT l3, location, SUM(qty) AS Total FROM example.products GROUP BY l3;"
    query_result = engine.execute(query)
    return query_result


if __name__ == "__main__":
    main()
