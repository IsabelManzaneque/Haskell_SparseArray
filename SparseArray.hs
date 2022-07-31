module SparseArray where

data Value a = Null | Value a
  deriving (Eq,Read,Show)
data SparseArray a = Vacio | Nodo (Value a) (SparseArray a) (SparseArray a)  -- constructores:  vacio no recibe parametos, Nodo recibe 3 parametros
  deriving (Eq,Read,Show)


-- Función num2bin: recibe un Int y devuelve una lista con los dígitos de su representación en binario --
num2bin :: Int -> [Bool]   
num2bin 0 = [False]        
num2bin n = num2binAux n   
  where num2binAux :: Int -> [Bool]   
        num2binAux 0 = []
        num2binAux n = (num2binAux (div n 2))++[(mod n 2)==1]


-- Función newSparseArray: devuelve un SparseArray vacío --
newSparseArray :: Eq a => SparseArray a
newSparseArray = Vacio


-- Función set: recibe un SparseArray, una posición y un elemento y cambia el valor del SparseArray de dicha posición --
set :: Eq a => SparseArray a -> Int -> a -> SparseArray a 
-- Si el array es vacío, crea un nuevo array y se lo pasa a set
set Vacio index e = set (Nodo Null Vacio Vacio) index e
-- Si no es vacío, se lo pasa a auxSet
set (Nodo raiz izq dch) index e = auxSet (Nodo raiz izq dch) (num2bin index) e
  
  where auxSet :: SparseArray a -> [Bool] -> a -> SparseArray a        
        -- si la lista está vacia ha llegado a su destino, coloca el elemento en la raiz y devuelve el array
        auxSet (Nodo raiz izq dch) [] e = (Nodo (Value e) izq dch) 
        -- si no está vacia avanza recursivamente creando nodos intermedios si los necesita
        auxSet (Nodo raiz izq Vacio) (True:xs) e = auxSet (Nodo raiz izq (Nodo Null Vacio Vacio)) (True:xs) e
        auxSet (Nodo raiz izq dch) (True:xs) e = Nodo raiz izq (auxSet dch xs e)          
        auxSet (Nodo raiz Vacio dch) (False:xs) e = auxSet (Nodo raiz (Nodo Null Vacio Vacio) dch) (False:xs) e
        auxSet (Nodo raiz izq dch) (False:xs) e = Nodo raiz (auxSet izq xs e) dch 


-- Función get: recibe un SparseArray y una posición y devuelve el elemento del SparseArray en dicha posición --
get :: Eq a => SparseArray a -> Int -> (Value a)
  -- Si el array es vacío, devuelve null
get Vacio index = Null  
  -- Si no es vacío, lo recorre usando auxGet 
get (Nodo raiz izq dch) index = auxGet (Nodo raiz izq dch) (num2bin index)  
  
  where auxGet :: SparseArray a -> [Bool] -> (Value a)
        -- si el array o la lista están vacíos, devuelve null
        auxGet Vacio (x:xs) = Null
        auxGet Vacio [] = Null
        -- si la lista esta vacía ha llegado a su destino y devuelve la raiz
        auxGet (Nodo raiz izq dch) [] = raiz
        -- si no lo esta, avanza recursivamente por el array
        auxGet (Nodo raiz izq dch) (True:xs) = auxGet dch xs
        auxGet (Nodo raiz izq dch) (False:xs) = auxGet izq xs


-- Función clean: recibe un SparseArray y comprueba si la raiz es Null y los hijos vacíos. Si es así devuelve Vacio.
-- En caso contrario devuelve el mismo array
clean :: SparseArray a -> SparseArray a
clean Vacio = Vacio
clean (Nodo Null Vacio Vacio) = Vacio
clean (Nodo raiz izq dch) = (Nodo raiz izq dch)


-- Función delete: recibe un SparseArray y una posición y devuelve el SparseArray resultado de eliminar dicha posición --
--                 También elimina todos los nodos vacíos que resulten de la eliminación                               --
delete :: Eq a => SparseArray a -> Int -> SparseArray a
-- Recorre el array usando una lista de booleans
delete (Nodo raiz izq dch) index = auxDelete (Nodo raiz izq dch) (num2bin index)  

  where auxDelete :: SparseArray a -> [Bool] -> SparseArray a
        -- si el array o la lista están vacíos, devuelve null
        auxDelete Vacio [] = Vacio
        auxDelete Vacio (x:xs) = Vacio
        -- si la lista esta vacia ha llegado al nodo destino y cambia el valor de la raiz a null
        auxDelete (Nodo raiz izq dch) [] = clean(Nodo Null izq dch)       
        -- si no lo esta, avanza recursivamente por el array
        auxDelete (Nodo raiz izq dch) (True:xs) = clean (Nodo raiz izq (auxDelete dch xs))
        auxDelete (Nodo raiz izq dch) (False:xs) = clean (Nodo raiz (auxDelete izq xs) dch)    


