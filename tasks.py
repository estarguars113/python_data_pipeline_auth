from pandas_datareader import data
from datetime import datetime
import json

from celery_app import app

@app.task
def get_stock_info(stock: str, start: datetime, end: datetime =datetime.now() ,source: str ='yahoo'):
    """
        Fetch info from onlinesource
        params:
            name: dataset name
            start: left boundary date range
            end: right boundary date range
            data_source: source name

        returns:
            json
    """
    df = data.DataReader(stock, source, start, end)
    df['Stock'] = stock
    agg = df.groupby('Stock').agg({
        'Open': ['min', 'max', 'mean', 'median'],
        'Adj Close': ['min', 'max', 'mean', 'median'],
        'Close': ['min', 'max', 'mean', 'median'],
        'High': ['min', 'max', 'mean', 'median'],
        'Low': ['min', 'max', 'mean', 'median'],
    })
    agg.columns = [' '.join(col).strip() for col in agg.columns.values]
    return agg.to_json()

