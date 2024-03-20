#----------------------Variables y Tipos de Datos----------------------

#Ruby maneja dinámicamente los tipos de datos, lo que facilita la escritura de código. Aquí hay ejemplos más detallados, incluyendo operaciones con strings y arrays.

numero = 10         # Integer
precio = 99.99      # Float
nombre = "Ruby"     # String
esta_activado = true # Boolean

# Trabajando con strings y interpolación
nombre = "Juan"
saludo = "Hola, #{nombre}!"
puts saludo  # Salida: Hola, Juan!

# Arrays con varios tipos de datos
mi_array = [1, "dos", 3.0, [4, "cinco"], "seis"]
puts mi_array[3][1]  # Salida: cinco

# Operaciones con arrays
numeros = [1, 2, 3, 4, 5]
numeros.push(6)         # Agrega al final
numeros.insert(0, 0)    # Inserta al inicio
puts numeros.join(", ") # Salida: 0, 1, 2, 3, 4, 5, 6


# ----------------------Comentarios----------------------

# Esto es un comentario de una línea

=begin
Esto es un comentario
de varias líneas
=end


# ----------------------Estructuras de Control----------------------

#Las estructuras de control en Ruby permiten tomar decisiones o repetir acciones de manera más compleja.


# Uso avanzado de if/else
puntuacion = 85
resultado = if puntuacion >= 90
              "A"
            elsif puntuacion >= 80
              "B"
            else
              "C"
            end
puts "Tu calificación es: #{resultado}"

# Iterando con .each
numeros = [1, 2, 3, 4, 5]
numeros.each do |numero|
  puts numero * 10  # Multiplica cada número por 10
end


#----------------------Colecciones----------------------

#Ruby proporciona estructuras de datos muy flexibles, como arrays y hashes, que pueden contener cualquier tipo de datos.


# Hashes más complejos
usuarios = {
  "juan" => {
    edad: 25,
    email: "juan@example.com",
    hobbies: ["fútbol", "pintura"]
  },
  "maria" => {
    edad: 30,
    email: "maria@example.com",
    hobbies: ["lectura", "jardinería"]
  }
}

usuarios.each do |nombre, datos|
  puts "Nombre: #{nombre}, Edad: #{datos[:edad]}, Email: #{datos[:email]}"
  puts "Hobbies: #{datos[:hobbies].join(", ")}"
end


#----------------------Métodos----------------------

#Los métodos en Ruby pueden aceptar parámetros y devolver valores, lo que los hace muy útiles para reutilizar código.


# Método con argumentos y retorno
def descripcion_usuario(nombre, edad, *hobbies)
  descripcion = "#{nombre}, de #{edad} años, disfruta de "
  descripcion += hobbies.join(", ")
  return descripcion
end

puts descripcion_usuario("Juan", 25, "fútbol", "pintura", "videojuegos")
# Salida: Juan, de 25 años, disfruta de fútbol, pintura, videojuegos


#----------------------Programación Orientada a Objetos----------------------

#Ruby es un lenguaje orientado a objetos desde su núcleo, lo que significa que casi todo en Ruby es un objeto.


class Usuario
  attr_accessor :nombre, :edad  # Permite leer y escribir nombre y edad

  def initialize(nombre, edad)
    @nombre = nombre
    @edad = edad
  end

  def saludo
    "Hola, mi nombre es #{@nombre} y tengo #{@edad} años."
  end
end

usuario = Usuario.new("Laura", 32)
puts usuario.saludo  # Salida: Hola, mi nombre es Laura y tengo 32 años.


#----------------------Bloques, Procs y Lambdas----------------------

# Poderoso sistema de bloques, junto con Procs y Lambdas, que te permiten escribir código más flexible y reusable

# Bloque simple
[1, 2, 3].each do |n|
    puts n * 10
end
  
# Procs
mi_proc = Proc.new { |nombre| puts "Hola, #{nombre}" }
mi_proc.call('Mundo')
  
# Lambdas
mi_lambda = lambda { |nombre| puts "Hola, #{nombre}" }
mi_lambda.call('Ruby')


#----------------------Manejo de expceciones----------------------

begin
  # Intenta hacer algo que podría fallar
  1 / 0
rescue ZeroDivisionError => e
  puts "Error: #{e.message}"
end

#----------------------Módulos y Mixins----------------------

#Los módulos no solo sirven para organizar tu código, sino que también puedes usarlos para compartir funcionalidades entre clases mediante mixins.

module Saludador
  def saluda(nombre)
    puts "Hola, #{nombre}"
  end
end

class Usuario
  include Saludador
end

usuario = Usuario.new
usuario.saluda('Juan')

#----------------------Símbolos----------------------

mi_hash = { :nombre => "Juan", :edad => 25 }
puts mi_hash[:nombre]


#----------------------Metaprogramación----------------------
#Ruby es conocido por su capacidad de metaprogramación, que permite escribir programas que manipulan y generan código Ruby dinámicamente

#-----attr_accessor-----

class Usuario
  attr_accessor :nombre, :edad
  # Utiliza attr_accessor para definir getters y setters para :nombre y :edad
end

usuario = Usuario.new
usuario.nombre = "Laura"
puts usuario.nombre  # Salida: Laura

#-----.send()-----

class Saludo
  def hola
    "Hola Mundo!"
  end
end

objeto = Saludo.new
puts objeto.send(:hola)  # => "Hola Mundo!"

=begin
objeto.send(:hola) 

Dinamismo: send permite invocar un método cuyo nombre se pasa como argumento (en este caso, el símbolo :hola). Esto es útil cuando el nombre del método que quieres llamar se determina dinámicamente en tiempo de ejecución. Por ejemplo, podrías decidir qué método llamar basándote en la entrada del usuario o en otro proceso lógico.

Flexibilidad: Con send, puedes llamar a métodos privados o protegidos desde fuera de la clase del objeto, lo cual no es posible mediante la invocación directa. Esto brinda una mayor flexibilidad pero debe usarse con precaución para no violar los principios de encapsulamiento del diseño orientado a objetos.

Riesgo de seguridad: Dado que permite la llamada dinámica de métodos, incluyendo aquellos que son privados o protegidos, el uso de send puede introducir riesgos de seguridad si el nombre del método se basa en la entrada del usuario o fuentes no seguras. Es importante validar o sanear cualquier entrada que pueda influir en este aspecto.
=end


#-----define_method-----

class Usuario
  attr_accessor :role  # Esto proporciona métodos getter y setter para :role

  ["admin", "usuario"].each do |role|
    define_method("#{role}?") do
      self.role == role
    end
  end
end

usuario = Usuario.new
usuario.role = "admin"
puts usuario.admin?  # => true
puts usuario.usuario?  # => false

=begin
Utiliza define_method para crear métodos basados en los nombres de los roles (admin? y usuario?). Estos métodos comprueban si el valor del atributo role del objeto Usuario coincide con el nombre del método interrogativo correspondiente (sin el signo de interrogación).

Permite establecer el role de un objeto usuario a "admin" y luego verifica este role llamando a los métodos admin? y usuario?, devolviendo true para admin? y false para usuario?, ya que el role establecido es "admin".
=end
