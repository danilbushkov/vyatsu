package coursework.mobile_app.model

class Errors {
    companion object{
        fun getError(code:Int):String {
            return when(code){
                1->"Логин пуст"
                2->"Логин меньше 4 символов"
                3->"Пароль пуст"
                4->"Пароль меньше 6 символов"
                5->"Некорректный логин"
                6->"Некорректный пароль"
                7->"Неправильный логин или пароль"
                8->"Логин сушествует"
                9->"Вы не авторизованы"
                11->"Заголовок пуст"
                17->"Ошибка при получении данных"
                else -> ""
            }
        }
    }
}
