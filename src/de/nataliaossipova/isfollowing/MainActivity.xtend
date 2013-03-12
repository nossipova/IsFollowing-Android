package de.nataliaossipova.isfollowing

import android.app.Activity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView

class MainActivity extends Activity implements AsyncDelegate {

    override onCreate(Bundle it) {
        super.onCreate(it)
        R$layout::activity_main.setContentView

        val button = R$id::Button01.findViewById as Button
        button.onClickListener = [
            var communicator = new TwitterCommunicator
            communicator.delegate = this as AsyncDelegate
            if (communicator.isNetworkAvailable(this)) {
                val editText1 = this.findViewById(R$id::EditText01) as EditText
                val editText2 = this.findViewById(R$id::EditText02) as EditText
                communicator.execute(editText1.text.toString, editText2.text.toString)
            }
        ]
    }

    override showResult(Object it) {
        var isFollowing = Boolean::parseBoolean(it as String)
        var resultView = this.findViewById(R$id::ResultView) as TextView
        resultView.text = if (isFollowing) {

            // There seems to be a bug: android::R$string::yes returns 'ok' and android::R$string::no returns 'cancel'.
            this.getString(R$string::yes).toUpperCase
        } else {
            this.getString(R$string::no).toUpperCase
        }
    }
}
