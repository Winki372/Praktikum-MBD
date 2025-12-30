CREATE TRIGGER `trg_otomatis_mutasi_awal` 
    AFTER INSERT ON `buku` 
    FOR EACH ROW BEGIN
    INSERT INTO mutasi_buku (id_buku, jenis_mutasi, jumlah, keterangan)
    VALUES (NEW.id_buku, 'Masuk', NEW.stok_total, 'Stok Awal (Auto Trigger)');
END
