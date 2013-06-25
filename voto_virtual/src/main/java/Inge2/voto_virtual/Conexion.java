package Inge2.voto_virtual;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.vaadin.data.util.sqlcontainer.SQLContainer;
import com.vaadin.data.util.sqlcontainer.connection.JDBCConnectionPool;
import com.vaadin.data.util.sqlcontainer.connection.SimpleJDBCConnectionPool;
import com.vaadin.data.util.sqlcontainer.query.FreeformQuery;
import com.vaadin.data.util.sqlcontainer.query.TableQuery;

/**
 * Clase para realizar conexion con la base de datos PostgreSQL.
 * Recibe usuario y contraseNa en el constructor.
 * @author r1k4rd0
 */
public class Conexion {
    
	private static String nombreConexion;
	private static JDBCConnectionPool pool;
    
    public Conexion(String usuario, String password) {
    	nombreConexion = "jdbc:postgresql://anon01.tk/edecisiones?user=" + 
    							usuario + "&password=" + password;
    	try {
   			pool = new SimpleJDBCConnectionPool("org.postgresql.Driver",
			        "jdbc:postgresql://anon01.tk:5432/edecisiones", usuario, password, 2, 5);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    /**
     * Ejecuta un comando SQL (INSERT o UPDATE) y retorna si se tuvo exito o no.
     * @param sql Consulta en lenguaje SQL.
     * @return exito true si se ejecuto el comando, false sino.
     */
    public boolean ejecutar(String sql) {
        boolean exito = false;
        try {
            //Se abre la conexion utilizando el driver de postgres
            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(nombreConexion);
            Statement comando = conexion.createStatement();
            int n_resultado = comando.executeUpdate(sql);
            //Se ejecuta la instruccion SQL
           	System.out.println("Se modificaron "+n_resultado+" filas");
           	exito = true;
            //Hay que cerrar la conexion
            comando.close();
            conexion.close();
        } catch (Exception e) {
            //Es muy importante el try-catch para atrapar los posibles errores
            //que pueden ocurrir en las distintas consultas y comandos SQL
            System.out.println(e.getMessage());
        }
        //Se retorna si la ejecucion tuvo exito o no
        return exito;
    }

    /**
     * Realiza una consulta SQL y retorna el resultado en un ResultSet.
     * @param sql Consulta en lenguaje SQL.
     * @return resultado Objeto ResultSet con los datos o null si no hubo resultado.
     */
    public ResultSet consultar(String sql) {
    	ResultSet resultado = null;
        try {
            //Se abre la conexion utilizando el driver de postgres
            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(nombreConexion);
            Statement comando = conexion.createStatement();
            resultado = comando.executeQuery(sql);
            if(resultado != null) {
                //Si resultado != null la consulta genero resultado
                System.out.println("Consulta ejecutada correctamente");            	
            } else {
                //Sino entonces no se ejecuto la consulta o no genero resultado
                System.out.println("No se ejecuto la consulta o no genero resultado");
            }
            //Se cierra la conexion
            comando.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        //Se retorna el ResultSet
        return resultado;
    }
    
    /**
     * Realiza una consulta SQL y retorna el resultado en un doble ArrayList de Strings.
     * @param sql Consulta en lenguaje SQL.
     * @return resultado ArrayList con los datos o null si no hubo resultado.
     */
    public ArrayList<ArrayList<String>> consultarArray(String sql) {
        ArrayList<ArrayList<String>> resultado = new ArrayList<ArrayList<String>>();
        try {
            //Se abre la conexion utilizando el driver de postgres
            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(nombreConexion);
            Statement comando = conexion.createStatement();
            ResultSet result = comando.executeQuery(sql);
            
            if(result != null) {
                ResultSetMetaData metaData = result.getMetaData();
                int columnas = metaData.getColumnCount();
                //Iteracion sobre las filas
                while(result.next()){
                	ArrayList<String> temp = new ArrayList<String>();
                    for (int i=1; i<=columnas; i++){
                        //Se saca la informacion de cada columna
                        temp.add(result.getString(i));
                    }
                    resultado.add(temp);
                }
                result.close();
            } else {
                //Sino entonces no se ejecuto la consulta o no genero resultado
                System.out.println("No se ejecuto la consulta o no genero resultado");
            }
            //Se cierra la conexion
            comando.close();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        //Se retorna ArrayList o null (exito o no)
        return resultado;
    }
    
    /**
     * Recupera una tabla de la base de datos en un contenedor SQL.
     * @param nombreTabla nombre de la tabla de la base de datos a consultar.
     * @return container resultado de la consulta o null si no genera ninguno.
     */
    public SQLContainer consultarTabla(String nombreTabla){
    	SQLContainer container = null;    	
    	try {
    		TableQuery tablaBD = new TableQuery(nombreTabla, pool);
    		container = new SQLContainer(tablaBD);
        } catch (SQLException e) {
              e.printStackTrace();
        }   
    	return container;
    }
    
    /**
     * Realiza una consulta SQL y retorna el resultado en un SQLContainer.
     * @param sql Consulta en lenguaje SQL.
     * @return container Objeto SQLContainer con los datos o null si no hubo.
     */
    public SQLContainer consulta(String sql){
		SQLContainer container = null;
		FreeformQuery consulta = new FreeformQuery(sql, pool);
		try {
			container = new SQLContainer(consulta);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return container;
    }
    
    public void cerrar(){
    	pool.destroy();
    }
}
