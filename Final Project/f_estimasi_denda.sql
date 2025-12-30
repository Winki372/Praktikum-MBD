CREATE DEFINER=`root`@`localhost` FUNCTION `f_estimasi_denda`( 
    p_tgl_jatuh_tempo DATE,  
    p_tgl_kembali DATE 
) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN 
    DECLARE v_selisih_hari INT; 
    DECLARE v_tarif_per_hari DECIMAL(10, 2) DEFAULT 2000; 
    DECLARE v_total_denda DECIMAL(10, 2); 
    SET v_selisih_hari = DATEDIFF(p_tgl_kembali, p_tgl_jatuh_tempo); 
    IF v_selisih_hari > 0 THEN 
        SET v_total_denda = v_selisih_hari * v_tarif_per_hari; 
    ELSE 
        SET v_total_denda = 0; 
    END IF; 
    RETURN v_total_denda; 
END
