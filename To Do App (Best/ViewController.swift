

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //      -------------------------       Biến toàn cục       -------------------------
    
    //  1.      Biến tag giúp lưu lại các lựa chọn khi ấn btn_SCT
    var tag : Int = 0
    
    //  2.      Các mảng lưu các Item
    var mang_Sang   : [String] = []
    var mang_Chieu  : [String] = []
    var mang_Toi    : [String] = []
    
    //  3.      Mảng lưu hình ảnh
    let mang_Anh = ["Morning", "Afternoon", "Evening"]
    
    
    //      -------------------------       Ảnh Nền       -------------------------
    
    //  1.      Ánh xạ
    @IBOutlet weak var img_BG: UIImageView!
    
    
    
    //      -------------------------       View List       -------------------------
    
    //  1.      Ánh xạ
    @IBOutlet weak var View_List: UIVisualEffectView!               //  View List
    @IBOutlet weak var LeTrai_View_List: NSLayoutConstraint!        //  Lề trái
    
    //  2.      Các biến Frame
    var View_List_W : CGFloat = 0
    
    //  3.      Các hàm Action
    
    //  a)  Ấn vào làm ẩn hiện View List + Table View
    @IBAction func btn_List(_ sender: UIButton)
    {
        Doi2View()
    }
    
    //  b)  Ấn vào sẽ làm đổi nền, load Table View tương ứng
    @IBAction func btn_SCT(_ sender: UIButton)
    {
        switch sender.tag
        {
        case 0: img_BG.image = UIImage(named: mang_Anh[sender.tag])
        case 1: img_BG.image = UIImage(named: mang_Anh[sender.tag])
        case 2: img_BG.image = UIImage(named: mang_Anh[sender.tag])
            
        default: break
        }
        
        
        tag = sender.tag                     // Nạp dữ liệu mới cho Biến Tag
        
        self.title = mang_Anh[tag]           //  Đặt Title cho Navigation Bar hiện tại
        
        Doi2View()                           // Di chuyển 2 View
        
        TableV.reloadData()                  // Load lại Table Data
        
    }
    
    //  3.a)     Dời 1 View nào đó (Hàm hỗ trợ)
    func DoiView(LeTrai : NSLayoutConstraint, ToaDo : CGFloat)
    {
        UIView.animate(withDuration: 0.5, animations:
            {
                LeTrai.constant = ToaDo
                self.view.layoutIfNeeded()
        })
    }
    
    //  3.a)     Dời 2 view : List + Table (Hàm hỗ trợ)
    func Doi2View()
    {
        if LeTrai_View_List.constant < 0
        {
            DoiView(LeTrai: LeTrai_View_List, ToaDo: 0)                  //  Dời view List sang phải
            DoiView(LeTrai: LeTrai_TableV, ToaDo: View_List_W)           //  Dời view Table sang phải
        }
        else
        {
            DoiView(LeTrai: LeTrai_View_List, ToaDo: -View_List_W)       //  Dời view List sang trái
            DoiView(LeTrai: LeTrai_TableV, ToaDo: 0)                     //  Dời view Table sang trái
        }
    }
    
    
    //      -------------------------       Table View       -------------------------
    
    //      1.       Ánh xạ
    @IBOutlet weak var TableV: UITableView!                       //  Table View
    @IBOutlet weak var LeTrai_TableV: NSLayoutConstraint!    //  Lề trái
    
    //      2.      Các hàm Action
    
        //  a)  Thêm item
    @IBAction func btn_Add(_ sender: Any)
    {
        //  0.  Dời view List + table sang trái
        DoiView(LeTrai: LeTrai_View_List, ToaDo: -View_List_W)
        DoiView(LeTrai: LeTrai_TableV, ToaDo: 0)
        
        //  1.  Tạo hộp thoại
        let alert = UIAlertController(title: "Việc cần làm",
                                      message: "Hãy làm cho tốt!", preferredStyle: .alert)
        
        //  2.  Thêm Text Field
        alert.addTextField { (txt) in
            txt.placeholder = "Hãy nhập việc cần làm!"
        }
        
        //  3.  Tạo button
        
        //  a)  Thêm
        let btn_Them = UIAlertAction(title: "Thêm", style: .cancel)
        { (_) in
            
            //  Lấy thông tin trong Text Field
            let getTxt = alert.textFields![0].text! as String
       
            
            //  Thêm vào mảng lưu Việc tuỳ tag
            switch self.tag
            {
            case 0:
                do{
                    self.mang_Sang.append(getTxt)
                    self.TableV.insertRows(at: [IndexPath(item: self.mang_Sang.count - 1, section: 0)],
                                           with: .automatic)
                }
                
            case 1:
                do{
                    self.mang_Chieu.append(getTxt)
                    self.TableV.insertRows(at: [IndexPath(item: self.mang_Chieu.count - 1, section: 0)],
                                           with: .automatic)
                }
                
            case 2:
                do{
                    self.mang_Toi.append(getTxt)
                    self.TableV.insertRows(at: [IndexPath(item: self.mang_Toi.count - 1, section: 0)],
                                           with: .automatic)
                }
                
            default: break
            }
        }
        
        //  b)  Huỷ
        let btn_Huy = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
        
        //  4.  Thêm button vào Text Field
        alert.addAction(btn_Them);              alert.addAction(btn_Huy)
        
        //  5.  Hiện hộp thoại
        self.present(alert, animated: true, completion: nil)
        
        //  6.  Load lại Data trên Table View
        TableV.reloadData()
        
        }
    
    
        //  b)  Chỉnh sửa Table View
    @IBAction func btn_Edit(_ sender: UIButton)
    {
        DoiView(LeTrai: LeTrai_View_List, ToaDo: -View_List_W)       //  Dời view List sang trái
        DoiView(LeTrai: LeTrai_TableV, ToaDo: 0)                     //  Dời view Table sang trái
        
        TableV.isEditing = !TableV.isEditing
        
        switch TableV.isEditing
        {
            case true:  sender.setTitle("Done", for: .normal)
            case false: sender.setTitle("Edit", for: .normal)
        }
    }
    
    
    //      3.  Các hàm xử lí giao diện
    
    //  a)  Số dòng
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tag
        {
        case 0: return mang_Sang.count
        case 1: return mang_Chieu.count
        case 2: return mang_Toi.count
            
        default: break
        }
        
        return 0
    }
    
    //  b)  Cấu tạo 1 dòng
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch tag
        {
            case 0: cell.textLabel?.text = mang_Sang[indexPath.row]
            case 1: cell.textLabel?.text = mang_Chieu[indexPath.row]
            case 2: cell.textLabel?.text = mang_Toi[indexPath.row]
            
            default: break
        }
        
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    //  c)  Di chuyển các Cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //  d)  Xoá Cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            switch tag
            {
                case 0: mang_Sang.remove(at: indexPath.row)
                case 1: mang_Chieu.remove(at: indexPath.row)
                case 2: mang_Toi.remove(at: indexPath.row)
                
                default: break
            }
            
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //  1.  View List
        View_List_W = View_List.frame.size.width        //  Lấy độ rộng
        LeTrai_View_List.constant = -View_List_W        //  Đặt lề trái
        View_List.layer.cornerRadius = 15
        
        //  2.  Table View
        TableV.dataSource = self
        TableV.delegate = self
        
        //  3.  Navigation Bar
        self.title = "Morning"
        
    }

}

