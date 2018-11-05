import pandas as pd
#import sys
import mailbox
#import csv
from email.header import decode_header

#infile = sys.argv[1]
#outfile = sys.argv[2]
#infile = "2008-December.mbox"
#outfile = "out.csv"

def get_content(part):
    content = ''
    payload = part.get_payload()
    if isinstance(payload, str):
        content += payload
    else:
        for part in payload:
            content += get_content(part)
    return content

#with open(outfile, "w", newline="") as f:
#    writer = csv.writer(f)
#    writer.writerow(['date', 'from', 'subject', 'content'])
#    for index, message in enumerate(mailbox.mbox(infile)):
#        content = get_content(message)
#        row = [message['date'], message['from'].strip('>').split('<')[-1], decode_header(message['subject'])[0][0], content]
#        writer.writerow(row)

def mbox_df(infile):
    row = []
    for message in mailbox.mbox(infile):
        content = get_content(message)
        line = [message['date'], message['from'].strip('>').split('<')[-1], decode_header(message['subject'])[0][0], content]
        row.append(line)
    df = pd.DataFrame(row, columns=['date', 'from', 'subject', 'content'])
    return df
