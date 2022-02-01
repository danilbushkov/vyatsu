package coursework.mobile_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import android.widget.CheckBox
import android.widget.EditText

class AddTaskActivity : AppCompatActivity() {

    var editTitle:EditText?=null
    var editText:EditText?=null
    var completed: CheckBox?=null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_task)
        editTitle=findViewById(R.id.editAddTitle)
        editText=findViewById(R.id.editAddText)
        completed=findViewById(R.id.checkBoxCompleted)

        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

    }


    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            android.R.id.home ->{
                this.finish()
                return true
            }
        }
        return super.onOptionsItemSelected(item)


    }
}