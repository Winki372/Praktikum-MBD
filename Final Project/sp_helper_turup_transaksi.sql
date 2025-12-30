create procedure `sp_helper_tutup_transaksi`(
  in p_id_pinjam int
)
begin
  update peminjaman
  set status_peminjaman = 'Kembali',
  tanggal_kembali = curdate()
  where id_peminjaman = p_id_pinjam;
end
