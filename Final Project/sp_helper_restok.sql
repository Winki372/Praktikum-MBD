create procedure `sp_helper_restok`(
  in p_id_buku varchar(10),
  in p_jumlah int
)
begin
  update buku
  set stok_tersedia = stok_tersedia + p_jumlah
  where id_buku = p_id_buku;
end
