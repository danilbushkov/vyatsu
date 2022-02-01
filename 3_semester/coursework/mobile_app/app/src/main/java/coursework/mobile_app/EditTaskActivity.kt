package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.CheckBox
import android.widget.EditText

class EditTaskActivity : AppCompatActivity() {

    var editTitle: EditText?=null
    var editText: EditText?=null
    var completed: CheckBox?=null
    override fun onCreate(savedInstanceState: Bundle?) {
        title="Редактирование"

        editTitle=findViewById(R.id.editEditTitle)
        editText=findViewById(R.id.editEditText)
        completed=findViewById(R.id.checkBoxEditCompleted)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_task)


        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }


    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            android.R.id.home ->{
                this.finish()
                return true
            }
            R.id.menu_edit_info->{

                return true
            }
            R.id.menu_edit_delete ->{

                return true
            }
        }
        return super.onOptionsItemSelected(item)


    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.edit_menu, menu)
        return true
    }


}