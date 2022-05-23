package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.GroupRequestBean;
import member.MemberBean;
import subPage.groupPageBean;


public class dataTransDBBean {
	private static dataTransDBBean instance = new dataTransDBBean();
	
	public static dataTransDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	//Boards�뿉�꽌 groupmemberboard�뿉 �뱾�뼱媛�  �궡�슜 戮묒븘�삤湲�
	public dataTransBean getRecord(String b_id, int b_group) throws Exception{
		   Connection conn = null;
		   PreparedStatement pstm = null;
		   ResultSet rs = null;
		   String sql = "";
		   dataTransBean dtb = new dataTransBean();
		   
		   try{
		        conn = getConnection();
		    	sql = "select b_group, b_goal, b_dday, b_startdate, b_finishdate from boards where b_id =? and b_group = ?";
		    	pstm = conn.prepareStatement(sql);
		        pstm.setString(1, b_id);
		        pstm.setInt(2, b_group);
		        rs = pstm.executeQuery();
				
		        if(rs.next()){
		        	dtb.setGr_mem_gnum(rs.getInt("b_group"));
		        	dtb.setGroup_goal(rs.getString("b_goal"));
		        	dtb.setGroup_studydate(rs.getString("b_dday"));
		        	dtb.setGroup_startdate(rs.getString("b_startdate"));
		        	dtb.setGroup_finishdate(rs.getString("b_finishdate"));
		        	}
		        rs.close();
		        pstm.close();
		        conn.close();
		        }catch(Exception e){
		            e.printStackTrace();
		        }
				finally{
					try {
						if(pstm != null) pstm.close();
						if(conn != null) conn.close();
					}catch(Exception e2) {
						e2.printStackTrace();
					}
				}
			return dtb;
	}
	
	//紐⑥쭛�셿猷� 移쒓뎄�뱾
	//�쁽�옱 �씤�썝 �뒛由ш린
	public int updateStatus(int b_group, String b_id, int b_stmember, int b_status) {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		int re = -1;
		
		try{
			conn = getConnection();
			if(b_stmember != b_status) {
				sql = "update boards set b_status = b_status + 1 where b_group =? and b_id =?";
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, b_group);
				pstm.setString(2, b_id);
				rs = pstm.executeQuery();
				re = 1;
			}else {
				re = -1;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try {
				if(pstm != null) pstm.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	//踰덊샇 遺��뿬�븷�씪怨� �궗�슜 -> gr_mem_number 遺��뿬
	public int numTemp(int b_group) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int num = -1; 
		
		try{
			conn = getConnection();
				sql = "select b_status from boards where b_group=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_group);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					num = rs.getInt("b_status");
				}				
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return num;
	}
	
	//�떊泥��븳 移쒓뎄 �젙蹂� �엫�떆 �뀒�씠釉붾줈 �삷湲곌린
	public int memTemp(int gr_mem_number, int b_group, String mem_id, String b_id) throws Exception{ 
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int re = -1; 
		
		try {
			con = getConnection();
			//媛� �씤�썝�뱾 �엫�떆 �뀒�씠釉붾줈 �씠�룞
			sql = "insert into memtemp " + 
				  "(gr_mem_gnum, mem_id, gr_mem_number, gr_mem_name, mem_email, group_goal, " + 
				  "group_startdate, group_finishdate, group_interests, group_report, group_introduce) " + 
				  "select " + 
				  "b.b_group, a.mem_id, ?, " + 
				  "a.mem_name, a.mem_email, b.b_goal, " + 
				  "b.b_startdate, b.b_finishdate, b.b_interests, " + 
				  "a.mem_report, a.mem_introduce " + 
				  "from stmembers a, boards b " + 
				  "where a.mem_id = ?" + 
				  "and b.b_group = ? and b.b_id = ?";		
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, gr_mem_number);
			pstmt.setString(2, mem_id);
			pstmt.setInt(3, b_group);
			pstmt.setString(4, b_id);
			pstmt.executeUpdate(); 
			re = 1; 
			
			pstmt.close();
			con.close();
			System.out.println("�뼐�뒗 �벑濡�");
		}catch(Exception e) {
			System.out.println("濡앸벑 �뒗�뼐");
			e.printStackTrace();
		}
		return re;
	}
	
	public int upToGroupMemberBoard(int b_group) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int re = -1; 
		
		try {
			con = getConnection();
			//�씤�썝 �쟾遺� �떎 蹂대궡湲�
			sql =	"insert into groupmemberboard " + 
					"select * from memtemp where gr_mem_gnum=?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, b_group);
			pstmt.executeUpdate(); 
			re = 1; 
			
			pstmt.close();
			con.close();
			System.out.println("蹂듭궗 �셿猷�");
		}catch(Exception e) {
			System.out.println("�쓳 �븞�꽆�뼱媛�");
			e.printStackTrace();
		}
		return re;
	}
	
	public int goodByeFellows(int b_group) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int re = -1; 
		
		try {
			con = getConnection();
			sql =	"delete from memtemp where gr_mem_gnum=?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, b_group);
			pstmt.executeUpdate(); 
			re = 1; 
			
			pstmt.close();
			con.close();
			System.out.println("援노컮�씠");
		}catch(Exception e) {
			System.out.println("�쓳 �븞�꽆�뼱媛�");
			e.printStackTrace();
		}
		return re;
	}
}
