import {Table, Column, Model, PrimaryKey, CreatedAt, UpdatedAt} from 'sequelize-typescript';

@Table
export class EmailVerify extends Model<EmailVerify> {
  
  @PrimaryKey
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
      email: this.email
    }
  }
}