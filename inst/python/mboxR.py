# -*- coding: utf-8 -*-

"""mboxR

Created by JooYoung Seo, (jooyoung@psu.edu), on Nov 18, 2018.
All source codes in this file can be freely modified, repurposed, and shared with this claimer.

The source codes below are tailored for Python 3.x and can be passed into R environment using reticulate package."""


from pandas import DataFrame
from mailbox import mbox
from email.header import decode_header

def get_content(part):
    content = ''
    payload = part.get_payload()
    if isinstance(payload, str):
        content += payload
    else:
        for part in payload:
            content += get_content(part)
    return content

def mbox_df(infile):
    try:
        row = []
        for message in mbox(infile):
            content = get_content(message)
            line = [message['date'], message['from'], message['to'], decode_header(message['subject'])[0][0], content]
            row.append(line)
    except Exception as e:
        print("Something wrong with your mbox file(s). Check the file(s) if it is formed correctly. Maybe the size is too big?\nThe specific error message from Python: ", e)
    finally:
        df = DataFrame(row, columns=['date', 'from', 'to', 'subject', 'content'])
        return df

