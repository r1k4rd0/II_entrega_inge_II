package Inge2.voto_virtual;

import com.vaadin.annotations.AutoGenerated;
import com.vaadin.data.Item;
import com.vaadin.data.util.sqlcontainer.SQLContainer;
import com.vaadin.ui.AbsoluteLayout;
import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.CustomComponent;
import com.vaadin.ui.Label;
import com.vaadin.ui.TextArea;
import com.vaadin.ui.TextField;

@SuppressWarnings("serial")
public class AgregarTendencia extends CustomComponent {

	/*- VaadinEditorProperties={"grid":"RegularGrid,20","showGrid":true,"snapToGrid":true,"snapToObject":true,"movingGuides":false,"snappingDistance":10} */

	@AutoGenerated
	private AbsoluteLayout mainLayout;
	@AutoGenerated
	private Button button_4;
	@AutoGenerated
	private Label label_6;
	@AutoGenerated
	private TextField textField_4;
	@AutoGenerated
	private Label label_5;
	@AutoGenerated
	private Button button_3;
	@AutoGenerated
	private ComboBox comboBox_2;
	@AutoGenerated
	private Button button_2;
	@AutoGenerated
	private ComboBox comboBox_1;
	@AutoGenerated
	private Label label_4;
	@AutoGenerated
	private TextField textField_6;
	@AutoGenerated
	private Button button_1;
	@AutoGenerated
	private TextField textField_3;
	@AutoGenerated
	private TextField textField_2;
	@AutoGenerated
	private TextField textField_1;
	@AutoGenerated
	private TextArea textArea_1;
	@AutoGenerated
	private Label label_3;
	@AutoGenerated
	private Label label_2;
	@AutoGenerated
	private Label label_1;
	private Conexion conexion;
	private String NombreTendencia;
	/**
	 * The constructor should first build the main layout, set the
	 * composition root and then do any custom initialization.
	 *
	 * The constructor will not be automatically regenerated by the
	 * visual editor.
	 */
	public AgregarTendencia() {
		buildMainLayout();
		setCompositionRoot(mainLayout);
		

		// TODO add user code here
		AgregarDatos();
		PonerEnEvento();
		
		button_4.addClickListener(new Button.ClickListener() {
			public void buttonClick(ClickEvent event) {
				MyVaadinUI.getCurrent().setContent(new VentanaPrincipal());
			}
		});
	}

	
	
	private void AgregarDatos(){
		button_1.addListener(new Button.ClickListener() {
			
				@Override
				public void buttonClick(ClickEvent event) {
					String nombreT = textField_6.getValue();
					NombreTendencia = nombreT;
					String informacion = textArea_1.getValue();
					String enlaces = textField_1.getValue() + ", "+ textField_2.getValue() + ", "+ textField_3.getValue();
					String consulta = "INSERT INTO tendencia(nombre, informacion, enlaces) VALUES('" +nombreT+ "','"+informacion+"','"+enlaces+"');";
					conexion = new Conexion("rebeca", "ramirez.arroyo");
					if(conexion.ejecutar(consulta)){
						
						
					}
					else{
						
					}
	
				}
				
			});
	}
	
	private void PonerEnEvento(){
		String consulta = "SELECT nombre, id_evento FROM plebiscito UNION SELECT motivo, id_evento FROM eleccion;";
		 conexion = new Conexion("rebeca", "ramirez.arroyo");
		 if(conexion!=null){
			  SQLContainer resultado = conexion.consulta(consulta);
			  if(resultado != null){
				  comboBox_1.setInputPrompt("Seleccione un evento");
				  comboBox_1.setContainerDataSource(resultado);
				  comboBox_1.setItemCaptionPropertyId("nombre");
				  
				  button_2.addClickListener(new Button.ClickListener() {
					
					@Override
					public void buttonClick(ClickEvent event) {
						// TODO Auto-generated method stub
						final Item item = comboBox_1.getItem(comboBox_1.getValue());
						final String evento = item.getItemProperty("id_evento").toString();
						comboBox_2.addItem("Elección");
						comboBox_2.addItem("Plebiscito");
					
						
						
						
						
	                    insertarAEvento(evento);
					}
					
				  });
			  }
		 }
	}
				    
		
	
	
	private void insertarAEvento(final String evento){//id evento para meterlo en la tabla

		  button_3.addClickListener(new Button.ClickListener() {
			
			@Override
			public void buttonClick(ClickEvent event) {
				// TODO Auto-generated method stub
				String valor = (String) comboBox_2.getValue();
				if(valor=="Plebiscito"){
				   String idten = getIDtendencia();
				   int num = Integer.parseInt(idten);
				   String consulta = "INSERT INTO tendencia_plebiscito VALUES("+num+","+evento+");";
				   conexion = new Conexion("rebeca", "ramirez.arroyo");
				   if(conexion.ejecutar(consulta)){
					   //label_6.setValue("Se almaceno la tendencia en el evento correctamente");
					   agregarAResultadosPleb(num,evento);
				   }
				
				}
				
				if(valor=="Elección"){
					   String idten = getIDtendencia();
					   int num = Integer.parseInt(idten);
					   String consulta = "INSERT INTO tendencia_eleccion(id_tendencia,id_evento) VALUES("+num+","+evento+");";
					   conexion = new Conexion("rebeca", "ramirez.arroyo");
					   if(conexion.ejecutar(consulta)){
						   //label_6.setValue("Se almaceno la tendencia en el evento correctamente");
						   agregarAResultadosEle(num,evento);
					   }
					
					}
				
				
				
				
				
			}
		  });
	}
	
	private String getIDtendencia(){
		String valor=" ";
		String consulta = "SELECT id_tendencia FROM tendencia WHERE nombre='"+NombreTendencia+"';";
		 conexion = new Conexion("rebeca", "ramirez.arroyo");
		 if(conexion!=null){
			 SQLContainer resultado = conexion.consulta(consulta);
			  if(resultado != null){
				 resultado.firstItemId();
				 Item item = resultado.getItem(resultado.firstItemId());
				 String res = item.getItemProperty("id_tendencia").toString();
				 textField_4.setValue(res);         //setContainerDataSource(resultado);
				 valor = res;		  
				 
			  }
		 }
		 return valor;
	}
	
	private void agregarAResultadosPleb(int idtendencia, String idevento){
		  int numeve = Integer.parseInt(idevento);
		  String consulta = "INSERT INTO resultados_plebiscito VALUES("+numeve+","+idtendencia+", 0);";
		   conexion = new Conexion("rebeca", "ramirez.arroyo");
		   if(conexion.ejecutar(consulta)){
			   label_6.setValue("Se almaceno la tendencia en el evento plebiscito correctamente");
		   }
	}
	
	private void agregarAResultadosEle(int idtendencia, String idevento){
		  int numeve = Integer.parseInt(idevento);
		  String consulta = "INSERT INTO resultados_eleccion VALUES("+numeve+","+idtendencia+", 0);";
		   conexion = new Conexion("rebeca", "ramirez.arroyo");
		   if(conexion.ejecutar(consulta)){
			   label_6.setValue("Se almaceno la tendencia en el evento elección correctamente");
		   }
	}

	@AutoGenerated
	private AbsoluteLayout buildMainLayout() {
		// common part: create layout
		mainLayout = new AbsoluteLayout();
		mainLayout.setImmediate(false);
		mainLayout.setWidth("735px");
		mainLayout.setHeight("695px");
		
		// top-level component properties
		setWidth("735px");
		setHeight("695px");
		
		// label_1
		label_1 = new Label();
		label_1.setImmediate(false);
		label_1.setWidth("-1px");
		label_1.setHeight("-1px");
		label_1.setValue("Nombre");
		mainLayout.addComponent(label_1, "top:40.0px;left:80.0px;");
		
		// label_2
		label_2 = new Label();
		label_2.setImmediate(false);
		label_2.setWidth("-1px");
		label_2.setHeight("-1px");
		label_2.setValue("Informacion de tendencia");
		mainLayout.addComponent(label_2, "top:80.0px;left:80.0px;");
		
		// label_3
		label_3 = new Label();
		label_3.setImmediate(false);
		label_3.setWidth("-1px");
		label_3.setHeight("-1px");
		label_3.setValue("Digitar enlaces a videos o paginas web relacionados con tendencia");
		mainLayout.addComponent(label_3, "top:202.0px;left:69.0px;");
		
		// textArea_1
		textArea_1 = new TextArea();
		textArea_1.setImmediate(false);
		textArea_1.setWidth("340px");
		textArea_1.setHeight("-1px");
		mainLayout.addComponent(textArea_1, "top:100.0px;left:80.0px;");
		
		// textField_1
		textField_1 = new TextField();
		textField_1.setImmediate(false);
		textField_1.setWidth("357px");
		textField_1.setHeight("-1px");
		mainLayout.addComponent(textField_1, "top:240.0px;left:83.0px;");
		
		// textField_2
		textField_2 = new TextField();
		textField_2.setImmediate(false);
		textField_2.setWidth("360px");
		textField_2.setHeight("-1px");
		mainLayout.addComponent(textField_2, "top:280.0px;left:80.0px;");
		
		// textField_3
		textField_3 = new TextField();
		textField_3.setImmediate(false);
		textField_3.setWidth("360px");
		textField_3.setHeight("-1px");
		mainLayout.addComponent(textField_3, "top:240.0px;left:484.0px;");
		
		// button_1
		button_1 = new Button();
		button_1.setCaption("Agregar");
		button_1.setImmediate(true);
		button_1.setWidth("-1px");
		button_1.setHeight("-1px");
		mainLayout.addComponent(button_1, "top:327.0px;left:245.0px;");
		
		// textField_6
		textField_6 = new TextField();
		textField_6.setImmediate(false);
		textField_6.setWidth("277px");
		textField_6.setHeight("-1px");
		mainLayout.addComponent(textField_6, "top:40.0px;left:143.0px;");
		
		// label_4
		label_4 = new Label();
		label_4.setImmediate(false);
		label_4.setWidth("-1px");
		label_4.setHeight("20px");
		label_4.setValue("Seleccione evento al que quiere agregar la tendencia");
		mainLayout.addComponent(label_4, "top:405.0px;left:84.0px;");
		
		// comboBox_1
		comboBox_1 = new ComboBox();
		comboBox_1.setImmediate(false);
		comboBox_1.setWidth("160px");
		comboBox_1.setHeight("-1px");
		mainLayout.addComponent(comboBox_1, "top:445.0px;left:100.0px;");
		
		// button_2
		button_2 = new Button();
		button_2.setCaption("Agregar");
		button_2.setImmediate(true);
		button_2.setWidth("-1px");
		button_2.setHeight("-1px");
		mainLayout.addComponent(button_2, "top:443.0px;left:300.0px;");
		
		// comboBox_2
		comboBox_2 = new ComboBox();
		comboBox_2.setImmediate(false);
		comboBox_2.setWidth("-1px");
		comboBox_2.setHeight("-1px");
		mainLayout.addComponent(comboBox_2, "top:584.0px;left:89.0px;");
		
		// button_3
		button_3 = new Button();
		button_3.setCaption("Seleccionar");
		button_3.setImmediate(true);
		button_3.setWidth("-1px");
		button_3.setHeight("-1px");
		mainLayout.addComponent(button_3, "top:582.0px;left:289.0px;");
		
		// label_5
		label_5 = new Label();
		label_5.setImmediate(false);
		label_5.setWidth("-1px");
		label_5.setHeight("-1px");
		label_5.setValue("Indique tipo de evento");
		mainLayout.addComponent(label_5, "top:528.0px;left:89.0px;");
		
		// textField_4
		textField_4 = new TextField();
		textField_4.setImmediate(false);
		textField_4.setWidth("97px");
		textField_4.setHeight("-1px");
		mainLayout.addComponent(textField_4, "top:584.0px;left:423.0px;");
		
		// label_6
		label_6 = new Label();
		label_6.setImmediate(false);
		label_6.setWidth("200px");
		label_6.setHeight("-1px");
		label_6.setValue("Resultado");
		mainLayout.addComponent(label_6, "top:407.0px;left:469.0px;");
		
		// button_4
		button_4 = new Button();
		button_4.setCaption("Regresar");
		button_4.setImmediate(true);
		button_4.setWidth("120px");
		button_4.setHeight("26px");
		mainLayout.addComponent(button_4, "top:653.0px;left:225.0px;");
		
		return mainLayout;
	}

}
