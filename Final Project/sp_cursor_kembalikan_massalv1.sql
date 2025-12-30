CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cursor_pengembalian_massal`(
    IN p_id_anggota INT
)
BEGIN
    DECLARE selesai INT DEFAULT 0;
    DECLARE v_idpinjam INT;
    DECLARE v_idbuku VARCHAR(10);
    DECLARE v_jumlah INT DEFAULT 1; 
    
    DECLARE cur_kembali CURSOR FOR
        SELECT p.id_peminjaman, dp.id_buku
        FROM peminjaman p
        JOIN detail_peminjaman dp ON p.id_peminjaman = dp.id_peminjaman
        WHERE p.id_anggota = p_id_anggota 
          AND p.status_peminjaman = 'Dipinjam';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = 1;

    OPEN cur_kembali;

    loop_kembali: LOOP
        FETCH cur_kembali INTO v_idpinjam, v_idbuku;

        IF selesai = 1 THEN LEAVE loop_kembali; END IF;

        CALL sp_helper_restock(v_idbuku, 1);
        CALL sp_helper_tutup_transaksi(v_idpinjam);
        CALL sp_helper_log_kembali(p_id_anggota, v_idbuku);

    END LOOP;

    CLOSE cur_kembali;
    
    SELECT 'SUKSES: Semua buku yang dipinjam anggota ini telah diproses KEMBALI.' AS Laporan;

END

--belum ada denda
