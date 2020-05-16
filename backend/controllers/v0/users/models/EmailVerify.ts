import {Table, Column, Model, PrimaryKey, CreatedAt, UpdatedAt} from 'sequelize-typescript';

@Table
export class EmailVerify extends Model<EmailVerify> {
  
  @PrimaryKey
  @Column
  public hash!: string;

  @Column
  public last_name: string;

  @Column
  public first_name!: string;
  
  @Column
  public email!: string;

  @Column
  @CreatedAt
  public createdAt: Date = new Date();

  @Column
  @UpdatedAt
  public updatedAt: Date = new Date();

  short() {
    return {
      hash: this.hash
    }
  }
}