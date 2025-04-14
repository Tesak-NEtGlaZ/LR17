program ReverseNumbersInFile;

const
  InputFile = 'input.txt';
  OutputFile = 'output.txt';

type
  PNode = ^TNode;
  TNode = record
    data: integer;
    next: PNode;
  end;

var
  head, temp: PNode;
  num: integer;
  input, output: text;

procedure AddToHead(var head: PNode; value: integer);
var
  newNode: PNode;
begin
  New(newNode);
  newNode^.data := value;
  newNode^.next := head;
  head := newNode;
end;

procedure FreeList(var head: PNode);
var
  temp: PNode;
begin
  while head <> nil do
  begin
    temp := head;
    head := head^.next;
    Dispose(temp);
  end;
end;

begin
  head := nil;

  Assign(input, InputFile);
  Reset(input);

  while not Eof(input) do
  begin
    Readln(input, num);
    AddToHead(head, num);
  end;
  Close(input);

  Assign(output, OutputFile);
  Rewrite(output);

  temp := head;
  while temp <> nil do
  begin
    Writeln(output, temp^.data);
    temp := temp^.next;
  end;
  Close(output);

  FreeList(head);

  writeln('Числа успешно записаны в файл ', OutputFile, ' в обратном порядке.');
end.