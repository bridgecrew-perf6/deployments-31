import datetime
import json
import random
import requests


def put_data(conn:str, data_set:list)->bool:
    """
    Execute PUT command
    :args:
        conn:str - REST connection information
        data_set:list - list of JSON to put in database
    :params:
        status:bool
        headers:dict - REST header information
    """
    status = True
    headers = {
        'type': 'json',
        'dbms': 'nvidia',
        'table': 'traffic_data',
        'mode': 'streaming',
        'Content-Type': 'text/plain'
    }

    for row in data_set:
        try:
            r = requests.put(url='http://%s' % conn, headers=headers, data=row)
        except Exception as e:
            print('Failed to PUT data into %s (Error: %s)' % (conn, e))
            status = False
        else:
            if int(r.status_code) != 200:
                print('Failed to PUT data into %s (Network Error: %s)' % r.status_code)
                status = False

    return status


def san_jose()->list:
    """
    Generate speed data for San Jose
    :params:
        data:list - list of data to store in AnyLog
        value_dict:dict - place holder for data being generated
    :return:
        data
    """
    data = []
    value_dict = {
        'city': 'San Jose',
        'location': '37.373653, -121.927853',
        'timestamp': None,
        'speed': None
    }
    for i in range(1000):
        if random.random() > 0.5:
            value_dict['speed'] = round(random.randrange(55, 75, 1) + random.random(), 2)
        else:
            value_dict['speed'] = round(random.randrange(55, 75, 1) - random.random(), 2)

        value_dict['timestamp'] = datetime.datetime.now() - datetime.timedelta(days=int(random.randrange(1, 30, 1)),
                                                                               hours=int(random.randrange(0, 25, 1)),
                                                                               minutes=int(random.randrange(0, 59, 1)),
                                                                               seconds=int(random.randrange(0, 59, 1)))
        value_dict['timestamp'] = value_dict['timestamp'].strftime('%Y-%m-%d %H:%M:%S.%f')
        data.append(json.dumps(value_dict))

    return data


def san_francisco()->list:
    """
    Generate speed data for San Francisco
    :params:
        data:list - list of data to store in AnyLog
        value_dict:dict - place holder for data being generated
    :return:
        data
    """
    data = []
    value_dict = {
        'city': 'San Francisco',
        'location': '37.705860, -122.394284',
        'timestamp': None,
        'speed': None
    }
    for i in range(1000):
        if random.random() > 0.5:
            value_dict['speed'] = round(random.randrange(50, 70, 1) + random.random(), 2)
        else:
            value_dict['speed'] = round(random.randrange(50, 70, 1) - random.random(), 2)

        value_dict['timestamp'] = datetime.datetime.now() - datetime.timedelta(days=int(random.randrange(1, 30, 1)),
                                                                               hours=int(random.randrange(0, 25, 1)),
                                                                               minutes=int(random.randrange(0, 59, 1)),
                                                                               seconds=int(random.randrange(0, 59, 1)))
        value_dict['timestamp'] = value_dict['timestamp'].strftime('%Y-%m-%d %H:%M:%S.%f')
        data.append(json.dumps(value_dict))

    return data


def main():
    put_data(conn='localhost:32149', data_set=san_jose())
    put_data(conn='localhost:32159', data_set=san_francisco())



if __name__ == '__main__':
    main()