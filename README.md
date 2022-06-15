#
# myBSN Unofficial

Maybank ada MAE & Maybank2U, CIMB ada CIMB Clicks, RHB ada apps sendiri.
BSN? masih oldskool guna website.


Disebabkan rasa ketagih nak tengok duit dalam bank, ditambah pula rasa menyirap
nak kene hadap authentication process, berbekalkan ilmu programming,
maka terhasil lah projek ni. Main point is to enable auto login and see important 
financial info swiftly.

Project ni tak pakai any database to store any information. User's
private data are being stored in user's phone. To prevent unwanted data exploits, password
is encrypted before storing in user's phone.


#
# Environment Variables

To run this project, you will need to add the following environment 
variables to your folder's .env file

`mobile/.env` :

`BASE_SERVER_URL` - since its a dev project, and using Android Studio's Virtual Android,
connect to local by using http://10.0.2.2:PORT

`ENCRYPT_KEY` - to encrypt and decrypt user's password by using AES algo

#
# Contributing

Contributions are always welcome! Plus, project ni pon cuma 
side project nak alihkan focus dari kerja hakiki.

#
## Authors

 <div style="display: flex; align-items: center; column-gap: 10px"> <img src="https://avatars.githubusercontent.com/u/55564994?v=4" style="border-radius: 50%" width="30" height="30"> <a href="https://www.github.com/irfan-zahir/" >@irfan-zahir</a></div>

# 
more updates to come
#
