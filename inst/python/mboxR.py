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
    row = []
    for message in mbox(infile):
        content = get_content(message)
        line = [message['date'], message['from'].strip('>').split('<')[-1], message['to'].strip('>').split('<')[-1], decode_header(message['subject'])[0][0], content]
        row.append(line)
    df = DataFrame(row, columns=['date', 'from', 'to', 'subject', 'content'])
    return df
