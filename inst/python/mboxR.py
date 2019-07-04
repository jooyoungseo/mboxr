# -*- coding: UTF-8 -*-

"""mboxR

Created by JooYoung Seo, (jooyoung@psu.edu), on Nov 18, 2018 (latest updated on July 4, 2019).
All source codes in this file can be freely modified, repurposed, and shared with this claimer.

The source codes below are tailored for Python 3.x and can be passed into R environment using reticulate package."""


from pandas import DataFrame
from mailbox import mbox
from email.header import decode_header, make_header
from email.utils import parsedate_to_datetime

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
            line = [str(parsedate_to_datetime(message['date'])), message['Message-ID'], message['In-Reply-To'], message['References'], message['from'], message['to'], message['Cc'], str(make_header(decode_header(message['subject']))), content]
            row.append(line)
    except Exception as e:
        print("Something wrong with your mbox file: ", infile, ". Check the file(s) if it is formed correctly. Maybe 'From ' in the mail body has not been correctly escaped as '>From '. Refer to the following resource:\nhttps://pymotw.com/3/mailbox/\nThe specific error message from Python: ", e, sep="")
    finally:
        df = DataFrame(row, columns=['date', 'message_ID', 'in_reply_to', 'references', 'from', 'to', 'cc', 'subject', 'content'])
        return df

