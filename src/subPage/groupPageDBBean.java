package subPage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;
import member.MemberBean;

public class groupPageDBBean {
	private static groupPageDBBean instance = new groupPageDBBean();
	
	public static groupPageDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
		//groupframe-44
		public int valNumCheck(String mem_id, int gr_mem_gnum) {
			int check = 0;
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "select gr_mem_number from groupmemberboard where gr_mem_gnum =? and mem_id =?";
			
			try {
				conn = getConnection();
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, gr_mem_gnum);
				pstm.setString(2, mem_id);
				rs = pstm.executeQuery();
				
				if(rs.next()) {
					check = rs.getInt("gr_mem_number"); //占쎌삂占쎄쉐 占쎈뻥占쎌벉
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return check;	
		}
		//groupframe-45
		public ArrayList<groupPageBean> memlist(int gr_mem_gnum){
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "select  gr_mem_gnum, mem_id, gr_mem_number,  gr_mem_name, group_startdate, group_finishdate, mem_email, group_introduce "+
					     "from groupmemberboard where gr_mem_gnum =? order by gr_mem_number asc";
			ArrayList<groupPageBean> list = new ArrayList<groupPageBean>();
			
			try {
				conn = getConnection();
				pstm = conn.prepareStatement(sql);
				pstm.setInt(1, gr_mem_gnum);
				rs = pstm.executeQuery();
				//groupboard 域밸챶竊숃린�뜇�깈, 占쎌뵠�뵳占� set
				
				while(rs.next()) {
					groupPageBean gsr = new groupPageBean();
					gsr.setGr_mem_gnum(rs.getInt("gr_mem_gnum"));
					gsr.setMem_id(rs.getString("mem_id"));
					gsr.setGr_mem_number(rs.getInt("gr_mem_number"));
					gsr.setGr_mem_name(rs.getString("gr_mem_name"));
					gsr.setGroup_startdate(rs.getString("group_startdate"));
					gsr.setGroup_finishdate(rs.getString("group_finishdate"));
					gsr.setMem_email(rs.getString("mem_email"));
					gsr.setGroup_introduce(rs.getString("group_introduce"));
					list.add(gsr);
				}
						
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		//groupframe - 48
		public BoardBean getBInfo(int gr_mem_gnum)throws Exception{
			BoardBean bb = new BoardBean();
			   Connection conn = null;
			   PreparedStatement pstm = null;
			   ResultSet rs = null;
			   String sql = "";
			   
			   try{
			        conn = getConnection();
			    	sql = "select * from boards where b_group=?";
			    	pstm = conn.prepareStatement(sql);
			        pstm.setInt(1,gr_mem_gnum);
			        rs = pstm.executeQuery();
					
			        if(rs.next()){
			        	bb.setB_group(rs.getInt("b_group"));
			        	bb.setB_goal(rs.getString("b_goal"));
			        	bb.setB_title(rs.getString("b_title"));
			        	bb.setB_startdate(rs.getString("b_startdate"));;
			        	bb.setB_finishdate(rs.getString("b_finishdate"));
			        	}
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
				return bb;
		}
		//confirm -38
		public ArrayList<groupPageBean> contentList(int gr_mem_gnum, String gr_mem_name){
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "select gr_mem_number, gr_mem_gnum, gr_mem_name, gr_mem_study, gr_mem_conid, gr_mem_date, gr_check from groupboard "+ 
						 "where gr_mem_name=? and gr_mem_gnum =? order by gr_mem_date asc";
			ArrayList<groupPageBean> list = new ArrayList<groupPageBean>();
			try {
				conn = getConnection();
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, gr_mem_name);
				pstm.setInt(2, gr_mem_gnum);
				rs = pstm.executeQuery();
				
				while(rs.next()) {
					groupPageBean gsr = new groupPageBean();
					gsr.setGr_mem_number(rs.getInt(1));
					gsr.setGr_mem_gnum(rs.getInt(2));
					gsr.setGr_mem_name(rs.getString(3));
					gsr.setGr_mem_study(rs.getString(4));
					gsr.setGr_mem_conid(rs.getInt(5));
					gsr.setGr_mem_date(rs.getString(6));
					gsr.setGr_check(rs.getInt(7));
					list.add(gsr);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;	
		}
		
		//input_process -22
		public int valcheck(String gr_mem_name , String gr_mem_date) {
			int check = 0;
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "select gr_mem_study from groupboard where gr_mem_name=? and gr_mem_date=?";
			
			try {
				conn = getConnection();
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, gr_mem_name);
				pstm.setString(2, gr_mem_date);
				rs = pstm.executeQuery();
				
				if(rs.next()) {
					check = 1; //占쎌삂占쎄쉐 占쎈뻥占쎌벉
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return check;	
		}
		//input_process -33
		public int insertRecord(groupPageBean gsr, int gr_mem_gnum) throws Exception{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		
		gr_mem_gnum = gsr.getGr_mem_gnum(); //域밸챶竊� 甕곕뜇�깈
		int gr_mem_number = gsr.getGr_mem_number(); //揶쏆뮇�뵥 甕곕뜇�깈
		String gr_mem_date = gsr.getGr_mem_date(); //占쎌궎占쎈뮎 占쎄텊筌욑옙
		String gr_mem_name = gsr.getGr_mem_name(); //占쎌뵠�뵳占�
		String gr_mem_study = gsr.getGr_mem_study(); //占쎌삂占쎄쉐 占쎄땀占쎌뒠
		int gr_mem_conid = gsr.getGr_mem_conid(); //占쎌삂占쎄쉐 疫뀐옙 甕곕뜇�깈
		
		int gr_check = 1;
		int count = 0;
		int re = -1;
		
	    try {
			conn = getConnection();
			pstm = conn.prepareStatement("select max(gr_mem_conid) from groupboard where gr_mem_name =?");
			pstm.setString(1,gr_mem_name);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}else {
				count = 1;
			}
			
			sql="insert into groupboard(gr_mem_number, gr_mem_gnum, gr_mem_name, gr_mem_study, gr_mem_conid, gr_mem_date, gr_check) "
					+ "values(?,?,?,?,?,?,?)";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1,gr_mem_number);
			pstm.setInt(2,gr_mem_gnum);
			pstm.setString(3, gr_mem_name);
			pstm.setString(4, gr_mem_study);
			pstm.setInt(5, count);
			pstm.setString(6, gr_mem_date);
			pstm.setInt(7,gr_check);
			pstm.executeUpdate();
			
			gsr.setGr_check(gr_check);
			re = 1;
			pstm.close();
			conn.close();
			
			
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try {
					if(pstm != null) pstm.close();
					if(conn != null) conn.close();
				}catch(Exception e2) {
					e2.printStackTrace();
				}
			}
		return re;
	}
	//edit -35 
	public groupPageBean getRecord(int gr_mem_gnum, String gr_mem_name, int gr_mem_conid) throws Exception{
		   groupPageBean gsr = new groupPageBean();
			
		   Connection conn = null;
		   PreparedStatement pstm = null;
		   ResultSet rs = null;
		   String sql = "";
		   
		   try{
		        conn = getConnection();
		    	sql = "select * from groupboard where gr_mem_name=? and gr_mem_conid =? and gr_mem_gnum=?";
		    	pstm = conn.prepareStatement(sql);
		        pstm.setString(1,gr_mem_name);
		        pstm.setInt(2,gr_mem_conid);
		        pstm.setInt(3,gr_mem_gnum);
		        rs = pstm.executeQuery();
				
		        if(rs.next()){
		        	gsr.setGr_mem_number(rs.getInt("gr_mem_number"));
		        	gsr.setGr_mem_gnum(rs.getInt("gr_mem_gnum"));
		        	gsr.setGr_mem_name(rs.getString("gr_mem_name"));
		        	gsr.setGr_mem_study(rs.getString("gr_mem_study"));
		        	gsr.setGr_mem_conid(rs.getInt("gr_mem_conid"));
		        	gsr.setGr_mem_date(rs.getString("gr_mem_date"));
		        	gsr.setGr_mem_gnum(rs.getInt("gr_mem_gnum"));
		        	}
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
			return gsr;
	}
	// edit_process -29
	public int editBoard(String gr_mem_study, int gr_mem_gnum, String gr_mem_name ,int gr_mem_conid) throws Exception{
		Connection conn = null;
		PreparedStatement pstm = null;
		int re = -1;
		try {
				conn = getConnection();
				pstm = conn.prepareStatement("update groupboard set gr_mem_study=? where gr_mem_gnum=? and gr_mem_name=? and gr_mem_conid=?");
				pstm.setString(1,gr_mem_study);
				pstm.setInt(2, gr_mem_gnum);
				pstm.setString(3,gr_mem_name);
				pstm.setInt(4, gr_mem_conid);
				pstm.executeUpdate();
					
				re = 1;
			}catch (Exception e) {
			e.printStackTrace();
			}
			return re;
	}
	
	//揶쏆뮇�뵥 占쎌젟癰귨옙 筌믩쵐釉섓옙沅→묾占�
	public MemberBean getPrec(int gr_mem_gnum,String gr_mem_name, int gr_mem_number) throws Exception{
		   Connection conn = null;
		   PreparedStatement pstm = null;
		   ResultSet rs = null;
		   String sql = "";
		   MemberBean mb = new MemberBean();
		   
		   try{
		        conn = getConnection();
		    	sql = "select a.mem_id, a.mem_name, a.mem_interests, a.mem_introduce from stmembers a, (select mem_id from groupmemberboard where gr_mem_number=? and gr_mem_gnum=?) b where a.mem_id = b.mem_id";
		    	pstm = conn.prepareStatement(sql);
		        pstm.setInt(1,gr_mem_number);
		        pstm.setInt(2,gr_mem_gnum);
		        rs = pstm.executeQuery();
				
		        if(rs.next()){
		        	mb.setMem_id(rs.getString("mem_id"));
		        	mb.setMem_name(rs.getString("mem_name"));
		        	mb.setMem_interests(rs.getString("mem_interests"));
		        	mb.setMem_introduce(rs.getString("mem_introduce"));
		        	}
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
			return mb;
	}
}
