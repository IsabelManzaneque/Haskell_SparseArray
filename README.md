# Haskell_SparseArray
Implementación del tipo abstracto de datos Array Disperso en Haskell

## Tabla de contenidos
* [Información general](#información-general)
* [Tecnologías](#tecnologías)

## Información general

Programa en Haskell que permite al usuario usar arrays dispersos y mostrar que se puede acceder y modificar sus 
elementos en un tiempo logarítmico con respecto al índice utilizado. Consideraremos que los índices son valores 
enteros mayores o iguales a cero.

Se implementarán tres operaciones para trabajar con los arrays dispersos:
1. set: que recibirá un array disperso a, un índice i y un elemento e y devolverá el array disperso resultado de 
insertar en a el elemento e bajo el índice i. Si antes de la inserción hubiera un elemento en a indexado bajo ese 
mismo índice i, entonces el elemento anterior se perdería, siendo substituido por e.
2. get: que recibirá un array disperso a y un índice i y devolverá el elemento de a que esté indexado bajo el índice i. 
Si no existe, devolverá un valor Null.
3. delete: que recibirá un array disperso a y un índice i y devolverá el array disperso resultado de eliminar de a el 
elemento indexado bajo el índice i. Si no existiera un elemento indexado bajo ese índice, se devolverá el array disperso 
a sin ninguna modificación.

Estos arrays se van a implementar mediante un árbol binario en el que cada nodo (salvo la raíz) estará asociado a un 
número entero desde el 0 en adelante. 



## Tecnologías
La estructura se ha creado con:
* Haskell
* The Glasgow Haskell Compiler

