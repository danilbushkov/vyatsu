unit Command;


interface
type
    Commands: Array of Command;
    Arguments: Array of String;
    Cursor = Record //хранит координаты курсора
        x: integer;
        y: integer;
    end;

    Command = Record //хранит команду
        text: String;
        textCount: integer;
        cur: Cursor;
        cmd: String;
        args: Arguments;
    end;
    Buffer = Record
        cmds: Commands; //хранит прошлые команды
        count: integer; //количество команд
    end;

implementation


end.