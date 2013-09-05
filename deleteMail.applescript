set accountList to {"Akamai"}
set folderList to {¬
	{accountName:"Gmail", mailboxName:"INBOX/stuff", staleDays:14}, ¬
	{accountName:"gMail", mailboxName:"INBOX/things", staleDays:14}, ¬
		}
set currentDate to current date

tell application "Mail"
	repeat with curFolder in folderList
		set curAccountName to the accountName of curFolder
		set mailAccount to account curAccountName
		set trashCan to mailbox "Trash" of account curAccountName
		set mailboxName to mailboxName of curFolder
		set curMailbox to mailbox mailboxName of account curAccountName
		repeat with i from 1 to number of messages in curMailbox
			set curMessage to message i of curMailbox
			set difference to (currentDate - (date sent of curMessage)) div days
			if difference is greater than (staleDays of curFolder) then
				set mailbox of curMessage to mailbox "Trash" of account of mailbox of curMessage
			end if
		end repeat
	end repeat
end tell
