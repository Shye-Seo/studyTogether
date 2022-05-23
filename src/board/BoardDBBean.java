package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();

	public static BoardDBBean getInstance() {
		return instance;
	}

	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	
	public int insertBoard(BoardBean board) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int re = -1;
		
		int count = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(b_group) from boards");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}else {
				count = 1;
			}
			sql = "insert into boards(b_id, b_number, b_stmember, b_startdate, b_finishdate, "
					+ "b_title, b_goal, b_content, b_interests, b_area, B_LANGUAGE, B_INTER_CH, b_status, b_group) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getB_id());
			pstmt.setInt(2, count);
			pstmt.setInt(3, board.getB_stmember());
			pstmt.setString(4, board.getB_startdate());
			pstmt.setString(5, board.getB_finishdate());
			pstmt.setString(6, board.getB_title());
			pstmt.setString(7, board.getB_goal());
			pstmt.setString(8, board.getB_content());
			pstmt.setString(9, board.getInterests());
			pstmt.setString(10, board.getArea());
			pstmt.setString(11, board.getLanguages());
			pstmt.setString(12, board.getB_inter_c());
			pstmt.setInt(13, 1);
			pstmt.setInt(14, count);
			pstmt.executeQuery();
			re = 1;
			
			if(re == 1) {
				sql = "insert into memtemp " + 
						"(gr_mem_gnum, mem_id, gr_mem_number, gr_mem_name, mem_email, group_goal, " + 
						"group_startdate, group_finishdate, group_interests, group_report, group_introduce) " + 
						"select " + 
						"b.b_group, a.mem_id, ?, " + 
						"a.mem_name, a.mem_email, b.b_goal, " + 
						"b.b_startdate, b.b_finishdate, b.b_interests, " + 
						"a.mem_report, a.mem_introduce " + 
						"from stmembers a, boards b " + 
						"where a.mem_id = b.b_id " + 
						"and a.mem_id = ? and b.b_title= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, 1);
				pstmt.setString(2, board.getB_id());
				pstmt.setString(3, board.getB_title());
				pstmt.executeUpdate();
			}
			
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			throw e;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
/*20220429-김여옭*/
	
	public ArrayList<BoardBean> listBoard(String b_area, String b_inter_s, String b_inter_c){
		//ResultSet pageSet=null;
		Connection conn=null;
		PreparedStatement pstm = null;
		ResultSet rs=null;
		String sql = "";
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		try {
			conn = getConnection();
			if(b_area == null && b_inter_s == null && b_inter_c== null) {
				sql = "select * from boards where b_status != b_stmember order by b_group asc";
				pstm = conn.prepareStatement(sql);
				rs = pstm.executeQuery();
				
				while(rs.next()) {
					BoardBean bb = new BoardBean();
					bb.setB_group(rs.getInt("b_group"));
					bb.setB_id(rs.getString("b_id"));
					bb.setB_title(rs.getString("b_title"));
					bb.setB_content(rs.getString("b_content"));
					bb.setB_startdate(rs.getString("b_startdate"));
					bb.setB_finishdate(rs.getString("b_finishdate"));
					bb.setB_stmember(rs.getInt("b_stmember"));
					bb.setB_status(rs.getInt("b_status"));
					bb.setInterests(rs.getString("b_interests"));
					bb.setB_goal(rs.getString("b_goal"));
					bb.setArea(rs.getString("b_area"));
					bb.setLanguages(rs.getString("b_language"));
					bb.setB_inter_c(rs.getString("b_inter_ch"));
					
					boardList.add(bb);
				}
			}else if(b_area.equals("지역") && b_inter_s.equals("개발분야") && b_inter_c.equals("언어")) {
				sql = "select * from boards where b_status != b_stmember order by b_group asc";
				pstm = conn.prepareStatement(sql);
				rs = pstm.executeQuery();
				
				while(rs.next()) {
					BoardBean bb = new BoardBean();
					bb.setB_group(rs.getInt("b_group"));
					bb.setB_id(rs.getString("b_id"));
					bb.setB_title(rs.getString("b_title"));
					bb.setB_content(rs.getString("b_content"));
					bb.setB_startdate(rs.getString("b_startdate"));
					bb.setB_finishdate(rs.getString("b_finishdate"));
					bb.setB_stmember(rs.getInt("b_stmember"));
					bb.setB_status(rs.getInt("b_status"));
					bb.setInterests(rs.getString("b_interests"));
					bb.setB_goal(rs.getString("b_goal"));
					bb.setArea(rs.getString("b_area"));
					bb.setLanguages(rs.getString("b_language"));
					bb.setB_inter_c(rs.getString("b_inter_ch"));
					
					boardList.add(bb);
				}
			}else {
				sql = "select * from boards where b_area=? and b_language=? and b_inter_ch=? and where b_status != b_stmember order by b_group asc";
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, b_area); //지역
				pstm.setString(2, b_inter_c); //언어 => b_language
				pstm.setString(3, b_inter_s); //분야 => b_inter_ch
				rs = pstm.executeQuery();
				
				while(rs.next()) {
					BoardBean bb = new BoardBean();
					bb.setB_group(rs.getInt("b_group"));
					bb.setB_id(rs.getString("b_id"));
					bb.setB_title(rs.getString("b_title"));
					bb.setB_content(rs.getString("b_content"));
					bb.setB_startdate(rs.getString("b_startdate"));
					bb.setB_finishdate(rs.getString("b_finishdate"));
					bb.setB_stmember(rs.getInt("b_stmember"));
					bb.setB_status(rs.getInt("b_status"));
					bb.setInterests(rs.getString("b_interests"));
					bb.setB_goal(rs.getString("b_goal"));
					bb.setArea(rs.getString("b_area"));
					bb.setLanguages(rs.getString("b_language"));
					bb.setB_inter_c(rs.getString("b_inter_ch"));
					
					boardList.add(bb);
				}
			}
			rs.close();
			pstm.close();
			conn.close();
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstm != null) pstm.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return boardList;
	}
	
	public BoardBean getConInfo(int b_group) { // bnum : 게시글번호
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from boards where b_group=?";
		BoardBean bb = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_group);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bb = new BoardBean();
				bb.setB_group(rs.getInt("b_group"));
				bb.setB_id(rs.getString("b_id"));
				bb.setB_title(rs.getString("b_title"));
				bb.setB_content(rs.getString("b_content"));
				bb.setB_startdate(rs.getString("b_startdate"));
				bb.setB_finishdate(rs.getString("b_finishdate"));
				bb.setB_stmember(rs.getInt("b_stmember"));
				bb.setB_status(rs.getInt("b_status"));
				bb.setInterests(rs.getString("b_interests"));
				bb.setB_goal(rs.getString("b_goal"));
				bb.setArea(rs.getString("b_area"));
				bb.setLanguages(rs.getString("b_language"));
				bb.setB_inter_c(rs.getString("b_inter_ch"));
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return bb;
	}
	

	public int setNumber(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int re = -1;

		try {
			conn = getConnection();
			sql = "select b_id, b_status from boards where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getB_id());
			pstmt.setInt(2, board.getB_status());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String id = rs.getString(1);
				int status = rs.getInt(2);
				if (id.equals(board.getB_id()) && status == 1) {
					sql = "update b_group, b_gmember set b_group=b_group+1 and "
							+ "b_gmember=b_member+1 from boards where b_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, board.getB_group());
					pstmt.setInt(2, board.getB_gmember());
					pstmt.executeUpdate();
					re = 1;
				} else {
					re = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return re;
	}

	public int setStatus(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int re = -1;

		try {
			conn = getConnection();
			sql = "select b_id from boards where b_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getB_id());
			;
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String id = rs.getString(1);
				if (id.equals(board.getB_id())) {
					sql = "update b_status set b_status=1 from boards where b_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, board.getB_status());
					pstmt.executeUpdate();
					re = 1;
				} else {
					re = 0;
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
}
