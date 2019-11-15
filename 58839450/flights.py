import pandas
py_flights = pandas.read_csv("flights.csv")
py_flights = py_flights[py_flights['dest'] == "ORD"]
py_flights = py_flights[['carrier', 'dep_delay', 'arr_delay']]
py_flights = py_flights.dropna()
