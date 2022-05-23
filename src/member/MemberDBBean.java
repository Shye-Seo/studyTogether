package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;
import subPage.groupPageBean;

public class MemberDBBean {
	private static MemberDBBean instance = new MemberDBBean();

	public static MemberDBBean getInstance() {
		return instance; 
	}
	public Connection getConnection() throws Exception{
		
		Context ctx = new InitialContext(); 
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();	
	}
	//loginOk -15
	public int userCheck(String id, String pw) throws Exception {
		int re = -1;
		String sql = "select mem_pw from STMEMBERS where mem_id=?";
			try {
				Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, id);
				ResultSet rs = ps.executeQuery();

				if (rs.next()) { 
					String db_mem_pw = rs.getString("mem_pw");
					if (db_mem_pw.equals(pw)) { 
						re = 1;
					}else { 
						re = 0;
					}
				}else { 
					re = -1;
				}

				rs.close();
				ps.close();
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return re;
		}
	
	//loginOk -16
	public MemberBean getMember(String mem_id) throws Exception {
		String sql = "select * from STMEMBERS where mem_id=?";
		MemberBean member = null;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, mem_id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) { 
				member = new MemberBean();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_jumin(rs.getString("mem_jumin"));
				member.setMem_tel(rs.getString("mem_tel"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_interests(rs.getString("mem_interests"));
				member.setMem_introduce(rs.getString("mem_introduce"));
				member.setMem_report(rs.getInt("mem_report"));
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	//registerOk -16
	public int confirmID(String id) throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select mem_id from STMEMBERS where mem_id =?";
		int re= -1;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				re = 1;
			}
			else {
				re = 0;
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
			return re;
	}
	//registerOk -24
	public int insertMember(MemberBean Member) throws Exception{ 
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "insert into STMEMBERS values(STUDY_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?)";
		int re = -1; 
		BoardBean board = new BoardBean();
		board.getB_id();
		board.getStmembers_mem_num();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, Member.getMem_id());
			pstmt.setString(2, Member.getMem_pw());
			pstmt.setString(3, Member.getMem_name());
			pstmt.setString(4, Member.getMem_jumin());
			pstmt.setString(5, Member.getMem_tel());
			pstmt.setString(6, Member.getMem_email());
			pstmt.setString(7, Member.getMem_interests());
			pstmt.setString(8, Member.getMem_introduce());
			pstmt.setInt(9, Member.getMem_report());
			
			pstmt.executeUpdate(); 
			re = 1; 
			
			  if (re == 1) { con = getConnection(); pstmt = con.
			  prepareStatement("insert into BOARDS(mem_num,b_id) select mem_num,mem_id from STMEMBERS"
			  ); pstmt.executeUpdate(); re = 1; }
			  
			 
			
			pstmt.close();
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	//upLoad_Process - 29
	public int getRequest(String b_id, String b_title, int b_group, String mem_id, String mem_name) throws Exception{ 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql= "";
		int re = -1; 
		
		try {
			con = getConnection();
			
			pstmt = con.prepareStatement("select * from grouprequest where b_group=? and mem_id=?");
			pstmt.setInt(1, b_group);
			pstmt.setString(2, mem_id);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				pstmt = con.prepareStatement("select count(b_group) from grouprequest");
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1)+1;
				}else {
					count = 1;
				}
				
				sql = "insert into grouprequest(mem_name, mem_id, b_title, b_id, b_gmember, b_group) "
						+ "values(?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql); 
				pstmt.setString(1, mem_name);
				pstmt.setString(2, mem_id);
				pstmt.setString(3, b_title);
				pstmt.setString(4, b_id);
				pstmt.setInt(5, count);
				pstmt.setInt(6, b_group);
				
				pstmt.executeUpdate(); 
				re = 1; 
				
				System.out.println("신청완료");
				rs.close();
				pstmt.close();
				con.close();
			}
		}catch(Exception e) {
			System.out.println("돌아가");
			e.printStackTrace();
		}
		return re;
	}
	
	//내가 참여중인 스터디 정보 뽑아내기
		public ArrayList<groupPageBean> getMeDoing(String mem_id){
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			String sql = "select gr_mem_gnum, group_goal, group_startdate, group_finishdate, group_interests, group_introduce from groupmemberboard where mem_id = ?";
			ArrayList<groupPageBean> list = new ArrayList<groupPageBean>();
			try {
				conn = getConnection();
				pstm = conn.prepareStatement(sql);
				pstm.setString(1, mem_id);
				rs = pstm.executeQuery();
				
				while(rs.next()) {
					groupPageBean gpb = new groupPageBean();
					gpb.setGr_mem_gnum(rs.getInt(1));
					gpb.setGroup_goal(rs.getString(2));
					gpb.setGroup_startdate(rs.getString(3));
					gpb.setGroup_finishdate(rs.getString(4));
					gpb.setGroup_interests(rs.getString(5));
					gpb.setGroup_introduce(rs.getString(6));
					list.add(gpb);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;	
		}
		
		public MemberBean getUserInfo(String id) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        MemberBean member = null;
	 
	        try {
	            // ����
	            StringBuffer query = new StringBuffer();
	            query.append("SELECT * FROM STMEMBERS WHERE MEM_ID=?");
	 
	            conn = getConnection();
	            pstmt = conn.prepareStatement(query.toString());
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();
	 
	            if (rs.next()) {   // ȸ�������� DTO�� ��´�.
	                // �ڹٺ� ������ ��´�.
	            	member = new MemberBean();
					member.setMem_num(rs.getInt("mem_num"));
					member.setMem_id(rs.getString("mem_id"));
					member.setMem_pw(rs.getString("mem_pw"));
					member.setMem_name(rs.getString("mem_name"));
			//		member.setMem_jumin(rs.getInt("mem_jumin"));
					member.setMem_tel(rs.getString("mem_tel"));
					member.setMem_email(rs.getString("mem_email"));
					member.setMem_interests(rs.getString("mem_interests"));
					member.setMem_introduce(rs.getString("mem_introduce"));
					member.setMem_report(rs.getInt("mem_report"));
	            }
	            return member;
	 
	        } catch (Exception sqle) {
	            throw new RuntimeException(sqle.getMessage());
	        } finally {
	            // Connection, PreparedStatement�� �ݴ´�.
	            try{
	                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
	                if ( conn != null ){ conn.close(); conn=null;    }
	            }catch(Exception e){
	                throw new RuntimeException(e.getMessage());
	            }
	        }
	    }    // end getUserInfo
	
	
	public int updateMember(MemberBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		String sql="update STMEMBERS set mem_pw=?, mem_tel=?, mem_interests=?, mem_introduce=? where mem_id=?";
		
		try {
			conn=getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMem_pw());
			pstmt.setString(2, member.getMem_tel());
			pstmt.setString(3, member.getMem_interests());
			pstmt.setString(4, member.getMem_introduce());
			pstmt.setString(5, member.getMem_id());
			re = pstmt.executeUpdate();
			
			if(re == 1) {
				System.out.println("수정완료");
			}else {
				System.out.println("ㅄ");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return re;
	}
	public ArrayList<BoardBean> myList(String mem_id){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "select * from boards where b_id = ? order by b_group asc";
		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		try {
			conn = getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, mem_id);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setB_id(rs.getString("b_id"));
				bb.setB_title(rs.getString("b_title"));
				bb.setB_content(rs.getString("b_content"));
				
				
				bb.setB_startdate(rs.getString("b_startdate"));
				bb.setB_finishdate(rs.getString("b_finishdate"));
				
				bb.setB_stmember(rs.getInt("b_stmember"));
				
				bb.setInterests(rs.getString("b_interests"));
				bb.setB_goal(rs.getString("b_goal"));
				
				bb.setB_status(rs.getInt("b_status"));
				bb.setB_group(rs.getInt("b_group"));
				bb.setB_gmember(rs.getInt("b_gmember"));
				
				list.add(bb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
	
	public ArrayList<GroupRequestBean> reqList(String mem_id, int b_group){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "select * from grouprequest where b_id = ? and b_group=? order by b_group asc, b_gmember asc";
		ArrayList<GroupRequestBean> list = new ArrayList<GroupRequestBean>();
		try {
			conn = getConnection();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, mem_id);
			pstm.setInt(2, b_group);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				GroupRequestBean grb = new GroupRequestBean();
				grb.setMem_name(rs.getString(1));
				grb.setMem_id(rs.getString(2));
				grb.setB_title(rs.getString(3));
				grb.setB_id(rs.getString(4));
				grb.setB_gmember(rs.getInt(5));
				grb.setB_group(rs.getInt(6));
				list.add(grb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
		
	//湲곌컖
	public int deleteList(GroupRequestBean gsr) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		
		String sql="delete from grouprequest where b_group=? and mem_id=?";
		
		try {
			conn=getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gsr.getB_group());
			pstmt.setString(2, gsr.getMem_id());
			re = pstmt.executeUpdate();
			
			System.out.println("湲곌컖!");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("蹂묒떊");
		}
		return re;
	}
	//�옉�꽦�옄 �엫�쓽濡� 紐⑥쭛 �셿猷�
	//--> �씤�썝�뱾 groupboard, groupmemberboard濡� �씠�룞
	//--> �빐�떦 湲� 踰덊샇�쓽 grouprequest �궘�젣 (b_id, b_group �씠�슜�빐�꽌)
	//湲� 踰덊샇 議곗떖
	public MemberBean getKey(String b_id, int b_group) throws Exception {
		String sql = "select * from boards where b_id=? and b_group=?";
		MemberBean member = null;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, b_id);
			ps.setInt(1, b_group);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				
				member = new MemberBean();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_jumin(rs.getString("mem_jumin"));
				member.setMem_tel(rs.getString("mem_tel"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_interests(rs.getString("mem_interests"));
				member.setMem_introduce(rs.getString("mem_introduce"));
				member.setMem_report(rs.getInt("mem_report"));
			}
			con.close();
			ps.close();
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	@SuppressWarnings("resource")
    public int deleteMember(String id, String pw)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String dbpw = ""; // DB���� ��й�ȣ�� ��Ƶ� ����
        int x = -1;
        try {
            // ��й�ȣ ��ȸ
            StringBuffer query1 = new StringBuffer();
            query1.append("SELECT MEM_PW FROM STMEMBERS WHERE MEM_ID=?");
            // ȸ�� ����
            StringBuffer query2 = new StringBuffer();
            query2.append("DELETE FROM STMEMBERS WHERE MEM_ID=?");
            conn = getConnection();
            // �ڵ� Ŀ���� false�� �Ѵ�.
            conn.setAutoCommit(false);
            // 1. ���̵� �ش��ϴ� ��й�ȣ�� ��ȸ�Ѵ�.
            pstmt = conn.prepareStatement(query1.toString());
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                dbpw = rs.getString("mem_pw");
                if (dbpw.equals(pw)) { // �Էµ� ��й�ȣ�� DB��� ��
                    // ������� ȸ������ ����
                    pstmt = conn.prepareStatement(query2.toString());
                    pstmt.setString(1, id);
                    pstmt.executeUpdate();
                    conn.commit();
                    x = 1; // ���� ����
                } else {
                    x = 0; // ��й�ȣ �񱳰�� - �ٸ�
                }
            }
            return x;
        } catch (Exception sqle) {
            try {
                conn.rollback(); // ������ �ѹ�
            } catch (SQLException e) {
                e.printStackTrace();
            }
            throw new RuntimeException(sqle.getMessage());
        } finally {
            try{
                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
                if ( conn != null ){ conn.close(); conn=null;    }
            }catch(Exception e){
                throw new RuntimeException(e.getMessage());
            }
        }
    } // end deleteMember
	
	
	
}
