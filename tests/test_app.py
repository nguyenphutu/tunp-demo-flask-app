import pytest
from app.app import app


@pytest.fixture
def client():
    with app.test_client() as client:
        yield client


def test_home(client):
    rv = client.get('/')
    json_data = rv.get_json()
    assert json_data['message'] == 'Hello, CI/CD with Jenkins and Docker!'


def test_status(client):
    rv = client.get('/status')
    json_data = rv.get_json()
    assert json_data['status'] == 'App is running smoothly!'
