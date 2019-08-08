# python_data_pipeline_auth


## Setup
`
    sh
    docker build .
`

## Execute
`
    sh
    celery -A tasks worker --loglevel=info
`