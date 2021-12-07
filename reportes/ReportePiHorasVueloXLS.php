<?php
class  ReportePiHorasVueloXLS
{
    private $fila;
    private $objParam;

    function __construct(CTParametro $objParam){
        $this->objParam = $objParam;
        $this->url_archivo = "../../../reportes_generados/".$this->objParam->getParametro('nombre_archivo');
        //ini_set('memory_limit','512M');
        set_time_limit(400);
        $cacheMethod = PHPExcel_CachedObjectStorageFactory:: cache_to_phpTemp;
        $cacheSettings = array('memoryCacheSize'  => '10MB');
        PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);

        $this->docexcel = new PHPExcel();
        $this->docexcel->getProperties()->setCreator("PXP")
            ->setLastModifiedBy("PXP")
            ->setTitle($this->objParam->getParametro('titulo_archivo'))
            ->setSubject($this->objParam->getParametro('titulo_archivo'))
            ->setDescription('Reporte "'.$this->objParam->getParametro('titulo_archivo').'", generado por el framework PXP')
            ->setKeywords("office 2007 openxml php")
            ->setCategory("Report File");

        $this->docexcel->setActiveSheetIndex(0);

        $this->docexcel->getActiveSheet()->setTitle($this->objParam->getParametro('titulo_archivo'));

        $this->equivalencias=array(0=>'A',1=>'B',2=>'C',3=>'D',4=>'E',5=>'F',6=>'G',7=>'H',8=>'I',
            9=>'J',10=>'K',11=>'L',12=>'M',13=>'N',14=>'O',15=>'P',16=>'Q',17=>'R',
            18=>'S',19=>'T',20=>'U',21=>'V',22=>'W',23=>'X',24=>'Y',25=>'Z',
            26=>'AA',27=>'AB',28=>'AC',29=>'AD',30=>'AE',31=>'AF',32=>'AG',33=>'AH',
            34=>'AI',35=>'AJ',36=>'AK',37=>'AL',38=>'AM',39=>'AN',40=>'AO',41=>'AP',
            42=>'AQ',43=>'AR',44=>'AS',45=>'AT',46=>'AU',47=>'AV',48=>'AW',49=>'AX',
            50=>'AY',51=>'AZ',
            52=>'BA',53=>'BB',54=>'BC',55=>'BD',56=>'BE',57=>'BF',58=>'BG',59=>'BH',
            60=>'BI',61=>'BJ',62=>'BK',63=>'BL',64=>'BM',65=>'BN',66=>'BO',67=>'BP',
            68=>'BQ',69=>'BR',70=>'BS',71=>'BT',72=>'BU',73=>'BV',74=>'BW',75=>'BX',
            76=>'BY',77=>'BZ');

    }
    function setDatos ($datos) {
        $this->datos = $datos;
        //var_dump($this->datos);exit;
    }

    function imprimeDatos(){
        $datos = $this->datos;
        $nombre = $datos[0]['nombre'];
        $gestion = $datos[0]['gestion'];
        $periodo = $datos[0]['periodo'];
        $pago_total = $datos[0]['pago_total'];

        $gdImage = imagecreatefromjpeg('../../../sis_kactivos_fijos/reportes/LogoBoa.jpg');

        $objDrawing = new PHPExcel_Worksheet_MemoryDrawing();
        $objDrawing->setName('Sample image');
        $objDrawing->setDescription('Sample image');
        $objDrawing->setImageResource($gdImage);
        $objDrawing->setRenderingFunction(PHPExcel_Worksheet_MemoryDrawing::RENDERING_JPEG);
        $objDrawing->setMimeType(PHPExcel_Worksheet_MemoryDrawing::MIMETYPE_DEFAULT);
        $objDrawing->setHeight(20);
        $objDrawing->setWidth(200);
        $objDrawing->setCoordinates('A1');
        $objDrawing->setWorksheet($this->docexcel->getActiveSheet());

        $styleTitulos = array(
            'font' => array(
                'bold' => true,
                'size' => 15,
                'name' => 'Arial',
                'color' => array('rgb' => '2B4364')
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            )
        );

        $styleGestion = array(
            'font' => array(
                'bold' => true,
                'size' => 10,
                'name' => 'Arial',
                'color' => array('rgb' => '2B4364')
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            )
        );
        $styleFoot = array(
            'font' => array(
                'bold' => true,
                'size' => 10,
                'name' => 'Arial'
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_RIGHT,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array('rgb' => '#EFAA35')
            ),
            'borders' => array(
                'allborders' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN
                )
            )
        );

        $styleSubTitulos = array(
            'font'  => array(
                'bold'  => true,
                'size'  => 8,
                'name'  => 'Arial'
            ),
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
            ),
            'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_SOLID,
                'color' => array('rgb' => 'c5d9f1')
            ),
            'borders' => array(
                'allborders' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN
                )
            ));
        $this->docexcel->setActiveSheetIndex(0);
        $sheet0 = $this->docexcel->getActiveSheet();
        $this->docexcel->getActiveSheet()->getStyle('B1:G1')->applyFromArray($styleTitulos);
        $sheet0->mergeCells('C1:E1');
        $sheet0->setCellValue('C1', 'REPORTE HORAS VUELO PILOTOS - COPILOTOS');
        $sheet0->mergeCells('C2:E2');
        $this->docexcel->getActiveSheet()->getStyle('C2:E2')->applyFromArray($styleGestion);
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[0])->setWidth(50);
        $sheet0->setCellValue('C2', 'GESTIÓN: '.$gestion);
        $sheet0->mergeCells('C3:E3');
        $this->docexcel->getActiveSheet()->getStyle('C3:D3')->applyFromArray($styleGestion);
        $sheet0->setCellValue('C3', 'MES DE: '.$periodo);
        $sheet0->mergeCells('C4:E4');
        $this->docexcel->getActiveSheet()->getStyle('C4:E4')->applyFromArray($styleGestion);
        $sheet0->setCellValue('C4', 'Moneda(bolivianos)');

        $this->docexcel->getActiveSheet()->getStyle('A7:G7')->applyFromArray($styleSubTitulos);

        $ini = 7;
        //*************************************Cabecera*****************************************
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[0])->setWidth(40);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0,$ini,'NOMBRE PILOTO');
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[1])->setWidth(20);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$ini,'CI');
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[2])->setWidth(20);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$ini,'CARGO ERP');
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[3])->setWidth(20);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3,$ini,'CARGO SICNO');
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[4])->setWidth(55);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4,$ini,'NOMBRE ESCALA SALARIAL');
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[5])->setWidth(20);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5,$ini,'TIPO FLOTA');
        $this->docexcel->getActiveSheet()->getColumnDimension($this->equivalencias[6])->setWidth(15);
        $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(6,$ini,'HORAS VUELO');

        //*************************************Fin Cabecera*****************************************

        $fila = 8;
        $contador = 1;
        $tipo_flota= '';
        /////////////////////***********************************Detalle***********************************************
        foreach($datos as $value) {
            if ($value['tipo_flota'] == 'largo_alcance' ){
                $tipo_flota = 'Largo Alcance';
            } elseif ($value['tipo_flota'] == 'mediano_alcance'){
                $tipo_flota = 'Mediano Alcance';
            }else{
                $tipo_flota = 'Corto Alcance';
            }
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(0,$fila,$value['nombre_piloto']);
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(1,$fila,$value['ci']);
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(2,$fila,$value['pic_sic']);
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(3,$fila,$value['pic_sic_servicio']);
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(4,$fila,$value['escala_salarial']);
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(5,$fila,$tipo_flota);
            $this->docexcel->setActiveSheetIndex(0)->setCellValueByColumnAndRow(6,$fila,$value['horas_vuelo']);

            $fila++;
            $contador++;
        }
        //************************************************Fin Detalle***********************************************

    }

    function generarReporte(){
        $this->imprimeDatos();
        $this->docexcel->setActiveSheetIndex(0);
        $this->objWriter = PHPExcel_IOFactory::createWriter($this->docexcel, 'Excel5');
        $this->objWriter->save($this->url_archivo);
    }
}

?>