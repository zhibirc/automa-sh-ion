#!/usr/bin/env python3
# ------------------------------------------------------------------------------------------
# Fix "locale" attribute for all active Okta users to the given one.
# You can easily adopt it's logic for your needs.
# ------------------------------------------------------------------------------------------

import requests
from urllib.parse import parse_qs, urlparse

COLOR_GREEN = '\033[0;32m'
COLOR_RESET = '\033[0m'

OKTA_API_BASE_URL = 'https://<your-Okta-URL>/api/v1/users'
OKTA_API_KEY = '<your-Okta-API-key>'

NEW_LOCALE = 'en_US'
# if you have hundreds or thousands of users you cannot retrieve them all in one single request
REQUEST_LIMIT = 200

api_request_headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': f'SSWS {OKTA_API_KEY}'
}

list_users_request_params = {
    'filter': 'status eq "ACTIVE"',
    'limit': REQUEST_LIMIT
}

user_id_list = []

done = False
cursor = None

# first, filter users in according to pre-defined criteria
while not done:
    if cursor:
        list_users_request_params['after'] = cursor

    response = requests.get(
        OKTA_API_BASE_URL,
        params=list_users_request_params,
        headers=api_request_headers
    )

    if response.status_code != 200:
        raise Exception(f'Got HTTP {response.status_code} on listing users')

    user_id_list.extend(map(lambda user: user.get('id'), response.json()))

    if 'next' in response.links:
        next_url = response.links['next']['url']
        cursor = parse_qs(urlparse(next_url).query)['after'][0]
    else:
        done = True

# user's profile modification
payload = {'profile': {'locale': NEW_LOCALE}}

# change profile for each filtered user
for user_id in user_id_list:
    requests.post(
        f'{OKTA_API_BASE_URL}/{user_id}',
        headers=api_request_headers,
        json=payload
    )

print(f'{COLOR_GREEN}{len(user_id_list)} users processed successfully 👍{COLOR_RESET}')
